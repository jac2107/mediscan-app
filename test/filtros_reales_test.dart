import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicamentos_app/core/search/filter_values.dart';
import 'package:medicamentos_app/core/search/dosis_filter.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';

void main() {
  final rows =
      (jsonDecode(
                File(
                  'test/fixtures/medicamentos_filtros.json',
                ).readAsStringSync(),
              )
              as List)
          .cast<Map<String, dynamic>>();
  Map<String, dynamic> med(String c) =>
      rows.firstWhere((r) => r['codigo_interno'] == c);
  test('Coincidencias exactas por elemento, alias y sales diferentes', () {
    expect(
      coincideFiltro(med('MED-072')['principios_activos'], {
        '  TIAMINA  CLORHIDRATO ',
      }, CampoFiltro.principio),
      true,
    );
    expect(
      coincideFiltro(med('MED-072')['principios_activos'], {
        'piridoxina clorhidrato',
      }, CampoFiltro.principio),
      true,
    );
    expect(
      coincideFiltro(med('MED-072')['principios_activos'], {
        'amina',
      }, CampoFiltro.principio),
      false,
    );
    expect(
      coincideFiltro(
        ['Diclofenaco potásico'],
        {'Diclofenaco sódico'},
        CampoFiltro.principio,
      ),
      false,
    );
    expect(
      coincideFiltro('["Oral","Intravenosa"]', {
        ' INTRAVENÓSA ',
      }, CampoFiltro.via),
      true,
    );
    expect(
      coincideFiltro(
        ['Subcutánea (NUNCA vía intravenosa)'],
        {'Intravenosa'},
        CampoFiltro.via,
      ),
      false,
    );
    expect(
      coincideFiltro(
        ['Subcutánea (NUNCA vía intravenosa)'],
        {'Subcutánea'},
        CampoFiltro.via,
      ),
      true,
    );
    expect(
      coincideFiltro(
        ['Sanofi / Medifarma / Genfar'],
        {'Genfar'},
        CampoFiltro.laboratorio,
      ),
      true,
    );
  });
  test('Opciones únicas y consistentes con todos los registros del CSV', () {
    expect(
      opcionesUnicas(['["Oral"," oral ","ORAL"]'], CampoFiltro.via),
      hasLength(1),
    );
    expect(
      opcionesUnicas([
        ['Tiamina clorhidrato (B1)', 'tiamina clorhidrato'],
      ], CampoFiltro.principio),
      hasLength(1),
    );
    for (final e in {
      'principios_activos': CampoFiltro.principio,
      'formas_farmaceuticas': CampoFiltro.forma,
      'vias_administracion': CampoFiltro.via,
      'laboratorios': CampoFiltro.laboratorio,
    }.entries) {
      for (final option in opcionesUnicas(rows.map((r) => r[e.key]), e.value))
        expect(
          rows.any((r) => coincideFiltro(r[e.key], {option}, e.value)),
          true,
          reason: option,
        );
    }
  });
  test(
    'Dosis reales: pautas, restricciones parciales, ausencias y ambigüedades',
    () {
      for (final code in [
        'MED-080',
        'MED-009',
        'MED-091',
        'MED-095',
        'MED-088',
      ])
        expect(
          tieneDosisInformada(med(code)['dosis_lactantes'], grupo: 'lactante'),
          false,
          reason: code,
        );
      for (final code in ['MED-001', 'MED-002'])
        expect(
          tieneDosisInformada(med(code)['dosis_lactantes'], grupo: 'lactante'),
          true,
          reason: code,
        );
      for (final code in ['MED-042', 'MED-021'])
        expect(
          tieneDosisInformada(med(code)['dosis_pediatrica'], grupo: 'nino'),
          true,
          reason: code,
        );
      expect(
        clasificarDosis(med('MED-095')['dosis_lactantes'], grupo: 'lactante'),
        EstadoTextoDosis.requiereRevision,
      );
      expect(
        tieneDosisInformada(
          med('MED-032')['dosis_adultos_mayores'],
          grupo: 'adulto_mayor',
        ),
        true,
      );
      expect(
        tieneDosisInformada('Contraindicado en menores de 6 meses.'),
        false,
      );
      expect(tieneDosisInformada('No recomendado en menores de 15 kg.'), false);
      expect(
        clasificarDosis('No se ha establecido su seguridad y eficacia.'),
        EstadoTextoDosis.sinInformacion,
      );
    },
  );
  test(
    '100 registros: OR, AND, buscador, sin resultados, contadores y limpieza',
    () async {
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(db.close);
      for (final r in rows)
        await db.upsertMedicamento(
          MedicamentosTableCompanion(
            id: Value(r['codigo_interno']),
            codigoInterno: Value(r['codigo_interno']),
            nombreComercial: Value(r['nombre_comercial']),
            categoria: Value(r['categoria']),
            principiosActivos: Value(jsonEncode(r['principios_activos'])),
            formasFarmaceuticas: Value(jsonEncode(r['formas_farmaceuticas'])),
            viasAdministracion: Value(jsonEncode(r['vias_administracion'])),
            laboratorios: Value(jsonEncode(r['laboratorios'])),
            dosisAdultos: Value(r['dosis_adultos']),
            dosisAdultosMayores: Value(r['dosis_adultos_mayores']),
            dosisPediatrica: Value(r['dosis_pediatrica']),
            dosisLactantes: Value(r['dosis_lactantes']),
          ),
        );
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      final n = container.read(filtrosProvider.notifier);
      Future<Set<String>> ids() async => (await container.read(
        resultadosBusquedaProvider.future,
      )).map((r) => r.medicamento.codigoInterno).toSet();
      expect(await ids(), hasLength(100));
      n.togglePrincipio('tiamina clorhidrato');
      expect(await ids(), {'MED-072'});
      n.togglePrincipio('Paracetamol');
      expect((await ids()).length, greaterThan(1));
      n.toggleVia('Oral');
      expect(
        (await ids()).every(
          (c) => coincideFiltro(med(c)['vias_administracion'], {
            'Oral',
          }, CampoFiltro.via),
        ),
        true,
      );
      n.setQuery('zzzzzzzzzzzzzzzz');
      expect(await ids(), isEmpty);
      n.limpiarFiltros();
      expect(container.read(filtrosProvider).query, 'zzzzzzzzzzzzzzzz');
      expect(container.read(filtrosProvider).totalFiltrosActivos, 0);
      n.limpiarTodo();
      expect(await ids(), hasLength(100));
      n.toggleGrupo('lactante');
      final babies = await ids();
      expect(babies, contains('MED-001'));
      expect(babies, isNot(contains('MED-095')));
      n.toggleGrupo('nino');
      expect((await ids()).containsAll(babies), true);
      n.toggleCategoria('categoria inexistente');
      expect(await ids(), isEmpty);
      n.limpiarTodo();
      expect(await ids(), hasLength(100));
    },
  );
}
