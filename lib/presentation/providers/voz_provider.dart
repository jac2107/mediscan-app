import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

enum EstadoVoz {
  idle,
  inicializando,
  escuchando,
  procesando,
  error,
  noDisponible,
}

class VozState {
  final EstadoVoz estado;
  final String textoReconocido;
  final String? mensajeError;
  final double nivelSonido;
  const VozState({
    this.estado = EstadoVoz.idle,
    this.textoReconocido = '',
    this.mensajeError,
    this.nivelSonido = 0,
  });
  VozState copyWith({
    EstadoVoz? estado,
    String? textoReconocido,
    String? mensajeError,
    double? nivelSonido,
  }) =>
      VozState(
        estado: estado ?? this.estado,
        textoReconocido: textoReconocido ?? this.textoReconocido,
        mensajeError: mensajeError,
        nivelSonido: nivelSonido ?? this.nivelSonido,
      );
}

// Inyectables para verificar los estados sin pedir permisos ni grabar en las pruebas.
final speechEngineProvider = Provider<SpeechToText>((ref) => SpeechToText());
final microphonePermissionProvider = Provider<Future<bool> Function()>(
  (ref) => () async => (await Permission.microphone.request()).isGranted,
);

class VozNotifier extends Notifier<VozState> {
  SpeechToText? _engine;
  SpeechToText get _stt {
    final SpeechToText engine =
        _engine ?? ref.read<SpeechToText>(speechEngineProvider);
    _engine = engine;
    return engine;
  }

  bool _inicializado = false;
  bool _disposed = false;
  bool _active = false;
  int _session = 0;
  Timer? _finishTimer;

  @override
  VozState build() {
    _disposed = false;
    ref.onDispose(() {
      _disposed = true;
      _active = false;
      _session++;
      _finishTimer?.cancel();
      final engine = _engine;
      if (engine != null) unawaited(engine.cancel().catchError((Object _) {}));
    });
    return const VozState();
  }

  bool _current(int session) => !_disposed && _active && session == _session;
  void _finishPresentation() {
    _finishTimer?.cancel();
    final session = _session;
    _finishTimer = Timer(const Duration(milliseconds: 350), () {
      if (_current(session) && state.estado == EstadoVoz.procesando) {
        state = state.copyWith(estado: EstadoVoz.idle, nivelSonido: 0);
      }
    });
  }

  Future<void> iniciarEscucha({
    required void Function(String texto) onResultado,
  }) async {
    if (state.estado == EstadoVoz.inicializando ||
        state.estado == EstadoVoz.escuchando ||
        state.estado == EstadoVoz.procesando) return;
    final session = ++_session;
    var finalReceived = false;
    _active = true;
    _finishTimer?.cancel();
    state = const VozState(estado: EstadoVoz.inicializando);
    try {
      final allowed = await ref.read(microphonePermissionProvider)();
      if (!_current(session)) return;
      if (!allowed) {
        _active = false;
        state = const VozState(
          estado: EstadoVoz.noDisponible,
          mensajeError:
              'No hay acceso al micrófono. Puedes escribir tu búsqueda.',
        );
        return;
      }
      if (!_inicializado) {
        _inicializado = await _stt.initialize(
          onStatus: _onStatus,
          onError: (error) {
            if (_disposed || !_active) return;
            _finishTimer?.cancel();
            state = state.copyWith(
              estado: EstadoVoz.error,
              nivelSonido: 0,
              mensajeError: error.errorMsg == 'error_no_match' ||
                      error.errorMsg == 'error_speech_timeout'
                  ? 'No pudimos reconocer el nombre. Intenta de nuevo o escríbelo.'
                  : 'El dictado no está disponible ahora. Escribe el nombre para buscar.',
            );
          },
        );
      }
      if (!_current(session)) return;
      if (!_inicializado) {
        _active = false;
        state = const VozState(
          estado: EstadoVoz.noDisponible,
          mensajeError:
              'El dictado no está disponible ahora. Escribe el nombre para buscar.',
        );
        return;
      }
      state = state.copyWith(estado: EstadoVoz.escuchando);
      await _stt.listen(
        onResult: (SpeechRecognitionResult result) {
          if (!_current(session) || finalReceived) return;
          final texto = result.recognizedWords;
          state = state.copyWith(textoReconocido: texto);
          // La búsqueda mantiene su comportamiento: solo aplica resultados finales.
          if (result.finalResult) {
            finalReceived = true;
            state = state.copyWith(
              estado: EstadoVoz.procesando,
              nivelSonido: 0,
            );
            if (texto.isNotEmpty) onResultado(texto);
            _finishPresentation();
          }
        },
        onSoundLevelChange: (level) {
          if (_current(session) && state.estado == EstadoVoz.escuchando) {
            state = state.copyWith(
              nivelSonido: ((level + 2) / 12).clamp(0.0, 1.0),
            );
          }
        },
        listenOptions: SpeechListenOptions(
          localeId: 'es_PE',
          listenMode: ListenMode.dictation,
          cancelOnError: false,
          partialResults: true,
        ),
      );
    } catch (_) {
      if (!_current(session)) return;
      _finishTimer?.cancel();
      state = state.copyWith(
        estado: EstadoVoz.error,
        nivelSonido: 0,
        mensajeError:
            'El dictado no está disponible ahora. Escribe el nombre para buscar.',
      );
    }
  }

  Future<void> detener() async {
    if (_disposed || state.estado != EstadoVoz.escuchando) return;
    state = state.copyWith(estado: EstadoVoz.procesando, nivelSonido: 0);
    try {
      await _stt.stop();
    } catch (_) {
      if (!_disposed)
        state = state.copyWith(
          estado: EstadoVoz.error,
          mensajeError:
              'No pudimos finalizar el dictado. Intenta de nuevo o escribe el nombre.',
        );
      return;
    }
    if (!_disposed && state.estado == EstadoVoz.procesando)
      _finishPresentation();
  }

  Future<void> cancelar() async {
    if (_disposed) return;
    _active = false;
    _session++;
    _finishTimer?.cancel();
    state = const VozState();
    try {
      await _engine?.cancel();
    } catch (_) {
      /* La interfaz ya dejó de escuchar. */
    }
  }

  void _onStatus(String status) {
    if (_disposed ||
        !_active ||
        state.estado == EstadoVoz.error ||
        state.estado == EstadoVoz.noDisponible) return;
    if (status == 'listening')
      state = state.copyWith(estado: EstadoVoz.escuchando);
    else if (status == 'notListening' || status == 'done') {
      state = state.copyWith(estado: EstadoVoz.procesando, nivelSonido: 0);
      _finishPresentation();
    }
  }
}

final vozProvider = NotifierProvider<VozNotifier, VozState>(VozNotifier.new);
