import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicamentos_app/core/search/filter_values.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';

void main() {
  final rows = (jsonDecode(File('test/fixtures/categorias_normalizadas.json')
          .readAsStringSync()) as List)
      .cast<Map<String, dynamic>>();
  test('100 categorías antiguas y JSON coinciden con el SQL, sin duplicados',
      () {
    for (final r in rows) {
      final expected = (r['despues'] as List).cast<String>();
      for (final value in [r['antes'], jsonEncode(expected), expected]) {
        expect(elementosFiltro(value, CampoFiltro.categoria), expected,
            reason: r['codigo_interno']);
        for (final category in expected) {
          expect(
              coincideFiltro(
                  value, {category.toUpperCase()}, CampoFiltro.categoria),
              true);
        }
      }
    }
    expect(opcionesUnicas(rows.map((r) => r['antes']), CampoFiltro.categoria),
        opcionesUnicas(rows.map((r) => r['despues']), CampoFiltro.categoria));
    expect(opcionesUnicas(rows.map((r) => r['despues']), CampoFiltro.categoria),
        hasLength(62));
    expect(
        opcionesUnicas(
            ['["Antibióticos"," antibioticos "]', 'Antibióticos (Macrólidos)'],
            CampoFiltro.categoria),
        hasLength(1));
    expect(
        coincideFiltro(
            '["Antiinflamatorios"]', {'inflamatorios'}, CampoFiltro.categoria),
        false);
    expect(textoCategorias('["Analgésicos","Antipiréticos"]'),
        'Analgésicos · Antipiréticos');
    expect(textoCategorias(null), isEmpty);
    expect(textoCategorias('[]'), isEmpty);
    expect(textoCategorias('[JSON inválido'), isEmpty);
    expect(textoCategorias('Categoría nueva del cliente'),
        'Categoría nueva del cliente');
  });

  for (final json in [false, true]) {
    test(
        'Categorías ${json ? "JSON" : "locales antiguas"}: OR, AND, búsqueda, limpieza',
        () async {
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(db.close);
      for (final r in rows) {
        await db.upsertMedicamento(MedicamentosTableCompanion(
          id: Value(r['codigo_interno']),
          codigoInterno: Value(r['codigo_interno']),
          nombreComercial: Value(r['codigo_interno']),
          categoria: Value(json ? jsonEncode(r['despues']) : r['antes']),
          viasAdministracion: const Value('["Oral"]'),
        ));
      }
      final container = ProviderContainer(overrides: [
        appDatabaseProvider.overrideWithValue(db),
      ]);
      addTearDown(container.dispose);
      final n = container.read(filtrosProvider.notifier);
      Future<Set<String>> ids() async =>
          (await container.read(resultadosBusquedaProvider.future))
              .map((r) => r.medicamento.codigoInterno)
              .toSet();
      Set<String> expected(Set<String> selected) => rows
          .where((r) => (r['despues'] as List).any(selected.contains))
          .map((r) => r['codigo_interno'] as String)
          .toSet();
      final opts = await container.read(opcionesFiltrosProvider.future);
      expect(opts['categorias'], hasLength(62));
      expect(await db.getCategorias(), opts['categorias']);
      n.toggleCategoria('  ANTIBIOTICOS ');
      expect(await ids(), expected({'Antibióticos'}));
      n.toggleCategoria('Analgésicos');
      expect(await ids(), expected({'Antibióticos', 'Analgésicos'}));
      expect(container.read(filtrosProvider).totalFiltrosActivos, 2);
      n.toggleVia('Oral');
      expect(await ids(), expected({'Antibióticos', 'Analgésicos'}));
      n.toggleVia('Intravenosa'); // OR dentro de vías
      expect(await ids(), expected({'Antibióticos', 'Analgésicos'}));
      n.toggleVia('Oral'); // AND entre vía y categoría
      expect(await ids(), isEmpty);
      n.limpiarTodo();
      n.toggleCategoria('Antipiréticos');
      n.setQuery('antipireticos');
      expect(await ids(), expected({'Antipiréticos'}));
      n.setQuery('zzzzzzzzzzzzzzzz');
      expect(await ids(), isEmpty);
      n.limpiarFiltros();
      expect(container.read(filtrosProvider).query, 'zzzzzzzzzzzzzzzz');
      expect(container.read(filtrosProvider).totalFiltrosActivos, 0);
      n.limpiarTodo();
      expect(await ids(), hasLength(100));
      n.toggleCategoria('Antibióticos');
      n.toggleCategoria(' ANTIBIÓTICOS ');
      expect(container.read(filtrosProvider).categorias, isEmpty);
    });
  }
}
