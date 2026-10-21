import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart' show Value;
import 'package:medicamentos_app/presentation/widgets/medicamento/medicamento_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicamentos_app/core/theme/app_theme.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/providers/sync_provider.dart';
import 'package:medicamentos_app/presentation/providers/connectivity_provider.dart';
import 'package:medicamentos_app/presentation/screens/inicio/inicio_app.dart';
import 'package:medicamentos_app/presentation/screens/medicamento/medicamento_detail_screen.dart';
import 'package:medicamentos_app/presentation/widgets/medicamento/image_viewer.dart';

class _LocalSync extends SyncNotifier {
  @override
  EstadoSync build() => EstadoSync.offline;
}

class _PhotoClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _PhotoRequest();
}

class _PhotoRequest extends Fake implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => _PhotoResponse();
}

class _PhotoResponse extends Fake implements HttpClientResponse {
  final bytes = File('assets/brand/farmafolio-icon.png').readAsBytesSync();
  @override
  int get statusCode => 200;
  @override
  int get contentLength => bytes.length;
  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;
  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      Stream<List<int>>.value(bytes).listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
}

void main() {
  setUpAll(() async {
    for (final family in ['Lora', 'Inter']) {
      final loader = FontLoader(family);
      for (final weight in family == 'Lora'
          ? ['Regular', 'Bold']
          : ['Regular', 'Medium', 'SemiBold', 'Bold'])
        loader.addFont(rootBundle.load('assets/fonts/$family-$weight.ttf'));
      await loader.load();
    }
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf')))
        .load();
  });
  final med = MedicamentosTableData(
    id: 'imagen',
    codigoInterno: 'MED-001',
    nombreComercial: 'Medicamento de prueba',
    nombreGenerico: 'Nombre genérico',
    categoria: 'Categoría',
    laboratorios: '[]',
    principiosActivos: '[]',
    concentraciones: '[]',
    formasFarmaceuticas: '[]',
    viasAdministracion: '[]',
    indicacionesTags: '[]',
    esFavorito: false,
    dosisAdultos: 'Texto original conservado.',
    fotoUrl: 'https://example.invalid/imagen.png',
  );
  for (final size in [const Size(390, 844), const Size(1280, 900)]) {
    testWidgets('Categorías JSON legibles en tarjeta y detalle ${size.width}',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final multiple = med.copyWith(
          categoria: const Value('["Analgésicos","Antipiréticos"]'));
      await tester.pumpWidget(MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
              body: MedicamentoCard(medicamento: multiple, onTap: () {}))));
      await tester.pumpAndSettle();
      expect(find.text('Analgésicos · Antipiréticos'), findsOneWidget);
      expect(find.textContaining('["'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(ProviderScope(
          overrides: [
            medicamentoPorIdProvider('imagen')
                .overrideWith((ref) async => multiple),
          ],
          child: MaterialApp(
              theme: AppTheme.light,
              home: const MedicamentoDetailScreen(medicamentoId: 'imagen'))));
      await tester.pumpAndSettle();
      expect(find.text('Analgésicos · Antipiréticos'), findsOneWidget);
      expect(find.textContaining('["'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
  for (final size in [const Size(390, 844), const Size(1280, 900)]) {
    testWidgets('Imagen expandida, compacta y regreso ${size.width}', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            medicamentoPorIdProvider('imagen').overrideWith((ref) async => med),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const MedicamentoDetailScreen(medicamentoId: 'imagen'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final photo = find.byKey(const Key('ampliar-imagen'));
      expect(tester.getRect(photo).width, 180);
      expect(tester.getRect(photo).center.dx, closeTo(size.width / 2, 1));
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile(
          'goldens/detalle_expandido_${size.width.toInt()}.png',
        ),
      );
      await tester.drag(find.byType(NestedScrollView), const Offset(0, -220));
      await tester.pumpAndSettle();
      expect(tester.getRect(photo).width, 64);
      expect(tester.getRect(photo).left, 24);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/detalle_compacto_${size.width.toInt()}.png'),
      );
      await tester.drag(find.byType(NestedScrollView), const Offset(0, 500));
      await tester.pumpAndSettle();
      expect(tester.getRect(photo).width, 180);
      await tester.tap(photo);
      await tester.pumpAndSettle();
      expect(find.byTooltip('Cerrar imagen'), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.byTooltip('Cerrar imagen'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets(
    'Visor: carga correcta, imagen completa, foco y fondo bloqueado',
    (tester) async {
      debugNetworkImageHttpClientProvider = () => _PhotoClient();
      addTearDown(() => debugNetworkImageHttpClientProvider = null);
      final scroll = ScrollController();
      addTearDown(scroll.dispose);
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: Builder(
            builder: (context) => Scaffold(
              body: ListView(
                controller: scroll,
                children: [
                  TextButton(
                    onPressed: () => abrirImagenMedicamento(
                      context,
                      'https://example.invalid/success.png',
                      'Imagen de prueba',
                    ),
                    child: const Text('Ampliar'),
                  ),
                  const SizedBox(height: 2000),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(() => precacheImage(
            const NetworkImage('https://example.invalid/success.png'),
            tester.element(find.byType(Scaffold)),
          ));
      debugNetworkImageHttpClientProvider = null;
      await tester.tap(find.text('Ampliar'));
      await tester.pumpAndSettle();
      expect(find.text('No pudimos cargar la imagen.'), findsNothing);
      expect(tester.widget<Image>(find.byType(Image)).fit, BoxFit.contain);
      expect(
        Focus.of(tester.element(find.byTooltip('Cerrar imagen'))).hasFocus,
        true,
      );
      await tester.drag(find.byType(Dialog), const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(scroll.offset, 0);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/visor_imagen.png'),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.byType(Dialog), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('Visor: error, cierre visible y Atrás', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => abrirImagenMedicamento(
                context,
                'https://example.invalid/foto.png',
                'Ficha',
              ),
              child: const Text('Abrir'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    expect(find.text('No pudimos cargar la imagen.'), findsOneWidget);
    await tester.tap(find.byTooltip('Cerrar imagen'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Cerrar imagen'), findsNothing);
    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byTooltip('Cerrar imagen'), findsNothing);
  });
  testWidgets('Inicio: carga real, error y reintento', (tester) async {
    final gate = Completer<ResultadoInicio>(),
        retry = Completer<ResultadoInicio>();
    var attempts = 0;
    await tester.pumpWidget(
      ProviderScope(
        child: InicioApp(
          inicializar: () {
            attempts++;
            return attempts == 1 ? gate.future : retry.future;
          },
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Preparando tu catálogo…'), findsOneWidget);
    gate.completeError(StateError('fallo local'));
    await tester.pumpAndSettle();
    expect(find.text('No pudimos preparar el catálogo.'), findsOneWidget);
    expect(find.text('Abrir catálogo sin conexión'), findsNothing);
    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    expect(find.text('Preparando tu catálogo…'), findsOneWidget);
    expect(find.text('Reintentar'), findsNothing);
    retry.complete(const ResultadoInicio(remotoDisponible: false));
    await tester.pumpAndSettle();
    expect(attempts, 2);
    expect(find.text('Abrir catálogo sin conexión'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Inicio: backend no disponible permite catálogo local', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          syncProvider.overrideWith(_LocalSync.new),
          isConnectedProvider.overrideWith((ref) => Stream.value(false)),
          todosMedicamentosProvider.overrideWith((ref) async => [med]),
        ],
        child: InicioApp(
          inicializar: () async =>
              const ResultadoInicio(remotoDisponible: false),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Abrir catálogo sin conexión'));
    await tester.pumpAndSettle();
    expect(find.text('Tu catálogo'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
