import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

enum EstadoVoz { idle, inicializando, escuchando, procesando, error, noDisponible }

class VozState {
  final EstadoVoz estado;
  final String textoReconocido;
  final String? mensajeError;

  const VozState({
    this.estado = EstadoVoz.idle,
    this.textoReconocido = '',
    this.mensajeError,
  });

  VozState copyWith({
    EstadoVoz? estado,
    String? textoReconocido,
    String? mensajeError,
  }) =>
      VozState(
        estado: estado ?? this.estado,
        textoReconocido: textoReconocido ?? this.textoReconocido,
        mensajeError: mensajeError ?? this.mensajeError,
      );
}

class VozNotifier extends Notifier<VozState> {
  final _stt = SpeechToText();
  bool _inicializado = false;

  @override
  VozState build() => const VozState();

  Future<void> iniciarEscucha({
    required void Function(String texto) onResultado,
  }) async {
    state = state.copyWith(estado: EstadoVoz.inicializando, textoReconocido: '');

    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      state = state.copyWith(
        estado: EstadoVoz.noDisponible,
        mensajeError: 'Permiso de micrófono denegado',
      );
      return;
    }

    if (!_inicializado) {
      _inicializado = await _stt.initialize(
        onStatus: _onStatus,
        onError: (e) {
          state = state.copyWith(
            estado: EstadoVoz.error,
            mensajeError: e.errorMsg,
          );
        },
      );
    }

    if (!_inicializado) {
      state = state.copyWith(estado: EstadoVoz.noDisponible);
      return;
    }

    state = state.copyWith(estado: EstadoVoz.escuchando);

    await _stt.listen(
      onResult: (SpeechRecognitionResult result) {
        final texto = result.recognizedWords;
        state = state.copyWith(textoReconocido: texto);
        if (result.finalResult && texto.isNotEmpty) {
          onResultado(texto);
        }
      },
      localeId: 'es_PE',
      listenMode: ListenMode.dictation,
      cancelOnError: false,
      partialResults: true,
    );
  }

  Future<void> detener() async {
    await _stt.stop();
    state = state.copyWith(estado: EstadoVoz.idle);
  }

  Future<void> cancelar() async {
    await _stt.cancel();
    state = state.copyWith(estado: EstadoVoz.idle, textoReconocido: '');
  }

  void _onStatus(String status) {
    if (status == 'listening') {
      state = state.copyWith(estado: EstadoVoz.escuchando);
    } else if (status == 'notListening' || status == 'done') {
      state = state.copyWith(estado: EstadoVoz.idle);
    }
  }
}

final vozProvider = NotifierProvider<VozNotifier, VozState>(VozNotifier.new);