import 'dart:io';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart' hide Column;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicamentos_app/core/search/dosis_filter.dart';
import 'package:medicamentos_app/app.dart';
import 'package:medicamentos_app/presentation/providers/voz_provider.dart';
import 'package:medicamentos_app/core/theme/app_theme.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/local/seed/seed_loader.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/providers/sync_provider.dart';
import 'package:medicamentos_app/presentation/providers/connectivity_provider.dart';
import 'package:medicamentos_app/presentation/screens/catalogo/catalogo_screen.dart';
import 'package:medicamentos_app/presentation/screens/medicamento/medicamento_detail_screen.dart';
import 'package:medicamentos_app/presentation/widgets/filtros/filtros_sheet.dart';

class VozEscuchando extends VozNotifier {
  @override
  VozState build() => const VozState(
        estado: EstadoVoz.escuchando,
        textoReconocido: 'Nombre dictado',
      );
}

class OfflineSync extends SyncNotifier {
  @override
  EstadoSync build() => EstadoSync.offline;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    for (final family in ['Lora', 'Inter']) {
      final loader = FontLoader(family);
      for (final weight in family == 'Lora'
          ? ['Regular', 'Bold']
          : ['Regular', 'Medium', 'SemiBold', 'Bold']) {
        loader.addFont(rootBundle.load('assets/fonts/$family-$weight.ttf'));
      }
      await loader.load();
    }
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  test('Dosis: excluye ausencias y conserva texto registrado', () {
    for (final value in [
      null,
      '',
      '  ',
      'No aplica',
      'NO CORRESPONDE.',
      'Sin información',
      'Sin informacion registrada',
      'No aplicable.',
    ]) {
      expect(tieneDosisInformada(value), false, reason: '$value');
    }
    expect(tieneDosisInformada('Según criterio del profesional'), false);
    expect(tieneDosisInformada('10 mg cada 8 horas'), true);
  });
  test('Precarga 100 fichas sin tabla retirada y mantiene dosis', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await SeedLoader(db).cargarSiVacio();
    expect(await db.getAllMedicamentos(), hasLength(100));
    expect(
      (await db.getAllMedicamentos()).any((m) => m.dosisAdultos != null),
      true,
    );
    final tables = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
        .get();
    expect(
      tables.map((r) => r.read<String>('name')),
      isNot(contains('medicamento_grupos')),
    );
    await SeedLoader(db).cargarSiVacio();
    expect(await db.getAllMedicamentos(), hasLength(100));
  });
  test(
    'Migración v3 a v4 conserva dosis, favoritos, historial y cursor',
    () async {
      final dir = await Directory.systemTemp.createTemp('farmafolio_migration');
      addTearDown(() => dir.delete(recursive: true));
      final file = File('${dir.path}/db.sqlite');
      final old = AppDatabase.forTesting(NativeDatabase(file));
      await old.upsertMedicamento(
        const MedicamentosTableCompanion(
          id: Value('test'),
          codigoInterno: Value('TEST'),
          nombreComercial: Value('Ficha de prueba'),
          dosisAdultos: Value('Dosis original'),
          esFavorito: Value(true),
        ),
      );
      await old.insertHistorial(
        HistorialTableCompanion(
          id: const Value('h'),
          medicamentoId: const Value('test'),
          nombreSnapshot: const Value('Ficha de prueba'),
          fecha: Value(DateTime(2026)),
        ),
      );
      await old.setSyncMeta('max_cursor', '15');
      await old.customStatement(
        'CREATE TABLE medicamento_grupos (medicamento_id TEXT, grupo TEXT, estado TEXT)',
      );
      await old.customStatement('PRAGMA user_version = 3');
      await old.close();
      final db = AppDatabase.forTesting(NativeDatabase(file));
      addTearDown(db.close);
      expect(
        (await db.getMedicamentoById('test'))!.dosisAdultos,
        'Dosis original',
      );
      expect(await db.getFavoritos(), hasLength(1));
      expect(await db.getHistorial(), hasLength(1));
      expect(await db.getSyncMeta('max_cursor'), '15');
      expect(
        await db
            .customSelect(
              "SELECT name FROM sqlite_master WHERE name = 'medicamento_grupos'",
            )
            .get(),
        isEmpty,
      );
    },
  );
  test('Filtros por dosis combinan OR y respetan categoría con AND', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(() async {
      container.dispose();
      await db.close();
    });
    for (final (id, adult, child, category) in [
      ('a', '10 mg cada 8 horas', 'No aplica', 'A'),
      ('b', 'No corresponde', '10 mg cada 8 horas', 'A'),
      ('c', '10 mg cada 8 horas', '10 mg cada 8 horas', 'B'),
      ('d', 'Sin información', '', 'A'),
    ]) {
      await db.upsertMedicamento(
        MedicamentosTableCompanion(
          id: Value(id),
          codigoInterno: Value(id),
          nombreComercial: Value(id),
          categoria: Value(category),
          dosisAdultos: Value(adult),
          dosisPediatrica: Value(child),
        ),
      );
    }
    container.read(filtrosProvider.notifier).toggleGrupo('adulto');
    container.read(filtrosProvider.notifier).toggleGrupo('nino');
    container.read(filtrosProvider.notifier).toggleCategoria('A');
    expect(
      (await container.read(
        resultadosBusquedaProvider.future,
      ))
          .map((r) => r.medicamento.id),
      ['a', 'b'],
    );
  });
  final med = MedicamentosTableData(
    id: 'test',
    codigoInterno: 'TEST',
    nombreComercial: 'Medicamento de prueba',
    nombreGenerico: 'Nombre genérico',
    categoria: 'Categoría de prueba',
    laboratorios: '[]',
    principiosActivos: '["Principio de prueba"]',
    concentraciones: '["Presentación de prueba"]',
    formasFarmaceuticas: '["Tabletas"]',
    viasAdministracion: '["Oral"]',
    indicacionesTags: '[]',
    esFavorito: false,
    dosisAdultos: 'Texto de dosis conservado.',
    dosisPediatrica: 'Sin información',
  );

  testWidgets(
    'Catálogo: marca, búsqueda, vacío y filtros sin estados retirados',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            syncProvider.overrideWith(OfflineSync.new),
            isConnectedProvider.overrideWith((ref) => Stream.value(false)),
            todosMedicamentosProvider.overrideWith((ref) async => [med]),
            opcionesFiltrosProvider.overrideWith(
              (ref) async => {
                'categorias': ['Categoría de prueba'],
              },
            ),
            favoritosProvider.overrideWith((ref) async => [med]),
            historialProvider.overrideWith((ref) async => []),
          ],
          child: const MedicamentosApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(
        () => precacheImage(
          const AssetImage('assets/brand/farmafolio-logo.png'),
          tester.element(find.byType(Scaffold).first),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('Farmafolio'), findsOneWidget);
      expect(find.text('Tu catálogo'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/catalogo.png'),
      );
      await tester.enterText(find.byType(TextField), 'zzzzzzzz');
      await tester.pumpAndSettle();
      expect(find.text('No encontramos coincidencias'), findsOneWidget);
      await tester.tap(find.byTooltip('Borrar búsqueda'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Filtros'));
      await tester.pumpAndSettle();
      expect(find.byType(FiltrosSheet), findsOneWidget);
      expect(find.text('Estado de aplicabilidad:'), findsNothing);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/filtros.png'),
      );
      await tester.tap(find.byTooltip('Cerrar filtros'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Favoritos'));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/favoritos.png'),
      );
      await tester.tap(find.text('Historial'));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/historial.png'),
      );
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'Micrófono activo mantiene buscador y muestra controles de escucha',
    (tester) async {
      tester.binding.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.binding.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );

      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            syncProvider.overrideWith(OfflineSync.new),
            isConnectedProvider.overrideWith((ref) => Stream.value(false)),
            vozProvider.overrideWith(VozEscuchando.new),
            todosMedicamentosProvider.overrideWith((ref) async => [med]),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const CatalogoScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(
        () => precacheImage(
          const AssetImage('assets/brand/farmafolio-logo.png'),
          tester.element(find.byType(Scaffold).first),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byTooltip('Finalizar dictado'), findsOneWidget);
      expect(find.text('Cancelar dictado'), findsOneWidget);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/microfono.png'),
      );
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'Ficha conserva tres pestañas y dosis; texto ampliado sin overflow',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            medicamentoPorIdProvider('test').overrideWith((ref) async => med),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const MedicamentoDetailScreen(medicamentoId: 'test'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Grupos'), findsNothing);
      expect(find.text('Ficha'), findsOneWidget);
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/ficha.png'),
      );
      await tester.tap(find.text('Dosis'));
      await tester.pumpAndSettle();
      expect(find.text('Texto de dosis conservado.'), findsOneWidget);
      await expectLater(
          find.byType(MaterialApp), matchesGoldenFile('goldens/dosis.png'));
      expect(tester.takeException(), isNull);
      tester.platformDispatcher.textScaleFactorTestValue = 1.8;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );
}
