import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:medicamentos_app/presentation/providers/voz_provider.dart';

class FakeSpeech extends Fake implements SpeechToText {
  SpeechResultListener? result;
  SpeechStatusListener? status;
  SpeechErrorListener? error;
  SpeechSoundLevelChange? level;
  bool available = true;
  int listens = 0;
  int cancels = 0;
  @override
  Future<bool> initialize({
    SpeechErrorListener? onError,
    SpeechStatusListener? onStatus,
    debugLogging = false,
    Duration finalTimeout = SpeechToText.defaultFinalTimeout,
    List<SpeechConfigOption>? options,
  }) async {
    status = onStatus;
    error = onError;
    return available;
  }

  @override
  Future listen({
    SpeechResultListener? onResult,
    Duration? listenFor,
    Duration? pauseFor,
    String? localeId,
    SpeechSoundLevelChange? onSoundLevelChange,
    cancelOnError = false,
    partialResults = true,
    onDevice = false,
    ListenMode listenMode = ListenMode.confirmation,
    sampleRate = 0,
    SpeechListenOptions? listenOptions,
  }) async {
    listens++;
    result = onResult;
    level = onSoundLevelChange;
  }

  @override
  Future<void> stop() async {
    status?.call('done');
  }

  @override
  Future<void> cancel() async {
    cancels++;
  }

  void words(String value, {bool finalResult = false}) => result?.call(
        SpeechRecognitionResult.init([
          SpeechRecognitionWords(value, null, .9),
        ], finalResult ? ResultType.finalResult : ResultType.partial),
      );
}

void main() {
  test(
    'Permiso denegado muestra alternativa escrita sin iniciar el motor',
    () async {
      final fake = FakeSpeech();
      final c = ProviderContainer(
        overrides: [
          speechEngineProvider.overrideWithValue(fake),
          microphonePermissionProvider.overrideWithValue(() async => false),
        ],
      );
      addTearDown(c.dispose);
      await c
          .read(vozProvider.notifier)
          .iniciarEscucha(onResultado: (_) => fail('No debe buscar'));
      expect(c.read(vozProvider).estado, EstadoVoz.noDisponible);
      expect(c.read(vozProvider).mensajeError, contains('Puedes escribir'));
      expect(fake.listens, 0);
    },
  );
  test(
    'Motor no disponible conserva el estado de error y la alternativa escrita',
    () async {
      final fake = FakeSpeech()..available = false;
      final c = ProviderContainer(
        overrides: [
          speechEngineProvider.overrideWithValue(fake),
          microphonePermissionProvider.overrideWithValue(() async => true),
        ],
      );
      addTearDown(c.dispose);
      await c.read(vozProvider.notifier).iniciarEscucha(onResultado: (_) {});
      expect(c.read(vozProvider).estado, EstadoVoz.noDisponible);
      expect(fake.listens, 0);
    },
  );
  testWidgets(
    'Parciales solo actualizan la presentación; el resultado final busca una sola vez',
    (tester) async {
      final fake = FakeSpeech(), found = <String>[];
      final c = ProviderContainer(
        overrides: [
          speechEngineProvider.overrideWithValue(fake),
          microphonePermissionProvider.overrideWithValue(() async => true),
        ],
      );
      addTearDown(c.dispose);
      await c.read(vozProvider.notifier).iniciarEscucha(onResultado: found.add);
      expect(c.read(vozProvider).estado, EstadoVoz.escuchando);
      fake.words('Para');
      fake.level?.call(8);
      expect(c.read(vozProvider).textoReconocido, 'Para');
      expect(found, isEmpty);
      expect(c.read(vozProvider).nivelSonido, greaterThan(0));
      fake.words('Paracetamol', finalResult: true);
      fake.words('Paracetamol', finalResult: true);
      expect(found, ['Paracetamol']);
      expect(c.read(vozProvider).estado, EstadoVoz.procesando);
      await tester.pump(const Duration(milliseconds: 400));
      expect(c.read(vozProvider).estado, EstadoVoz.idle);
    },
  );
  testWidgets(
    'Finalizar escucha no pierde un resultado final que llegue después del cierre visual',
    (tester) async {
      final fake = FakeSpeech(), found = <String>[];
      final c = ProviderContainer(
        overrides: [
          speechEngineProvider.overrideWithValue(fake),
          microphonePermissionProvider.overrideWithValue(() async => true),
        ],
      );
      addTearDown(c.dispose);
      final n = c.read(vozProvider.notifier);
      await n.iniciarEscucha(onResultado: found.add);
      await n.detener();
      expect(c.read(vozProvider).estado, EstadoVoz.procesando);
      await tester.pump(const Duration(milliseconds: 400));
      fake.words('Texto final recibido', finalResult: true);
      expect(found, ['Texto final recibido']);
      await tester.pump(const Duration(milliseconds: 400));
    },
  );
  test(
    'Cancelar durante el permiso ignora resultados tardíos y evita iniciar una sesión',
    () async {
      final permission = Completer<bool>(), fake = FakeSpeech();
      final c = ProviderContainer(
        overrides: [
          speechEngineProvider.overrideWithValue(fake),
          microphonePermissionProvider.overrideWithValue(
            () => permission.future,
          ),
        ],
      );
      addTearDown(c.dispose);
      final n = c.read(vozProvider.notifier),
          pending = n.iniciarEscucha(
            onResultado: (_) => fail('Sesión cancelada'),
          );
      expect(c.read(vozProvider).estado, EstadoVoz.inicializando);
      await n.cancelar();
      permission.complete(true);
      await pending;
      expect(c.read(vozProvider).estado, EstadoVoz.idle);
      expect(fake.listens, 0);
    },
  );
  test(
    'Cancelar escucha evita que una transcripción tardía cambie el buscador',
    () async {
      final fake = FakeSpeech(), found = <String>[];
      final c = ProviderContainer(
        overrides: [
          speechEngineProvider.overrideWithValue(fake),
          microphonePermissionProvider.overrideWithValue(() async => true),
        ],
      );
      addTearDown(c.dispose);
      final n = c.read(vozProvider.notifier);
      await n.iniciarEscucha(onResultado: found.add);
      await n.cancelar();
      fake.words('Resultado tardío', finalResult: true);
      expect(found, isEmpty);
      expect(c.read(vozProvider).estado, EstadoVoz.idle);
    },
  );
  test('Error de reconocimiento muestra el mensaje correspondiente', () async {
    final fake = FakeSpeech();
    final c = ProviderContainer(
      overrides: [
        speechEngineProvider.overrideWithValue(fake),
        microphonePermissionProvider.overrideWithValue(() async => true),
      ],
    );
    addTearDown(c.dispose);
    await c.read(vozProvider.notifier).iniciarEscucha(onResultado: (_) {});
    fake.error?.call(SpeechRecognitionError('error_no_match', false));
    expect(c.read(vozProvider).estado, EstadoVoz.error);
    expect(c.read(vozProvider).mensajeError, contains('No pudimos reconocer'));
  });
}
