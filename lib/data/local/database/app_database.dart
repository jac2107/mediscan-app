import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ── Tablas ──────────────────────────────────────────────────────────────────

class MedicamentosTable extends Table {
  @override
  String get tableName => 'medicamentos';

  TextColumn get id => text()();
  TextColumn get codigoInterno => text().unique()();
  TextColumn get nombreComercial => text()();
  TextColumn get nombreGenerico => text().nullable()();
  TextColumn get categoria => text().nullable()();
  TextColumn get laboratorios => text().withDefault(const Constant('[]'))();
  TextColumn get descripcion => text().nullable()();
  TextColumn get principiosActivos => text().withDefault(const Constant('[]'))();
  TextColumn get composicionCompleta => text().nullable()();
  TextColumn get concentraciones => text().withDefault(const Constant('[]'))();
  TextColumn get formasFarmaceuticas => text().withDefault(const Constant('[]'))();
  TextColumn get presentacion => text().nullable()();
  TextColumn get viasAdministracion => text().withDefault(const Constant('[]'))();
  TextColumn get indicacionesTexto => text().nullable()();
  TextColumn get indicacionesTags => text().withDefault(const Constant('[]'))();
  TextColumn get contraindicaciones => text().nullable()();
  TextColumn get precaucionesAdvertencias => text().nullable()();
  TextColumn get efectosAdversos => text().nullable()();
  TextColumn get dosisAdultos => text().nullable()();
  TextColumn get dosisAdultosMayores => text().nullable()();
  TextColumn get dosisPediatrica => text().nullable()();
  TextColumn get dosisLactantes => text().nullable()();
  // Imagen: foto_path de Storage (prioridad) o URL externa de fuentes
  TextColumn get fotoUrl => text().nullable()();
  TextColumn get fechaRevision => text().nullable()();
  TextColumn get actualizadoEn => text().nullable()();
  BoolColumn get esFavorito => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class MedicamentoGruposTable extends Table {
  @override
  String get tableName => 'medicamento_grupos';

  TextColumn get medicamentoId => text()();
  TextColumn get grupo => text()(); // adulto | adulto_mayor | nino | lactante
  TextColumn get estado => text().withDefault(const Constant('no_evaluado'))();
  TextColumn get observacion => text().nullable()();

  @override
  Set<Column> get primaryKey => {medicamentoId, grupo};
}

class HistorialTable extends Table {
  @override
  String get tableName => 'historial';

  TextColumn get id => text()();
  TextColumn get medicamentoId => text()();
  TextColumn get nombreSnapshot => text()();
  TextColumn get tipo => text().withDefault(const Constant('busqueda'))();
  DateTimeColumn get fecha => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncMetaTable extends Table {
  @override
  String get tableName => 'sync_meta';

  TextColumn get clave => text()();
  TextColumn get valor => text()();

  @override
  Set<Column> get primaryKey => {clave};
}

// ── Database ─────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  MedicamentosTable,
  MedicamentoGruposTable,
  HistorialTable,
  SyncMetaTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openDatabase());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          await m.recreateAllViews();
          // En versiones anteriores, recrear todo.
          if (from < 3) {
            await customStatement('DROP TABLE IF EXISTS medicamentos');
            await customStatement('DROP TABLE IF EXISTS medicamento_grupos');
            await customStatement('DROP TABLE IF EXISTS historial');
            await customStatement('DROP TABLE IF EXISTS sync_meta');
            await m.createAll();
          }
        },
        onCreate: (m) => m.createAll(),
      );

  static QueryExecutor _openDatabase() =>
      driftDatabase(name: 'mediscan_v3.db');

  // ── Helpers JSON ────────────────────────────────────────────────────────────

  static List<String> jsonToList(String? json) {
    if (json == null || json.isEmpty) return [];
    try {
      final decoded = jsonDecode(json);
      if (decoded is List) return decoded.map((e) => e.toString()).toList();
      return [];
    } catch (_) {
      return [];
    }
  }

  static String listToJson(List<String> list) => jsonEncode(list);

  // ── Acceso directo a DAOs ───────────────────────────────────────────────────

  // Upsert medicamento (por codigoInterno como clave estable)
  Future<void> upsertMedicamento(MedicamentosTableCompanion companion) async {
    await into(medicamentosTable).insertOnConflictUpdate(companion);
  }

  Future<void> upsertGrupo(MedicamentoGruposTableCompanion companion) async {
    await into(medicamentoGruposTable).insertOnConflictUpdate(companion);
  }

  Future<List<MedicamentosTableData>> getAllMedicamentos() =>
      (select(medicamentosTable)
            ..where((t) => t.esFavorito.equals(false) | t.esFavorito.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.nombreComercial)]))
          .get();

  Future<MedicamentosTableData?> getMedicamentoById(String id) =>
      (select(medicamentosTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<MedicamentosTableData?> getMedicamentoPorCodigo(String codigo) =>
      (select(medicamentosTable)..where((t) => t.codigoInterno.equals(codigo)))
          .getSingleOrNull();

  Future<List<MedicamentoGruposTableData>> getGrupos(String medicamentoId) =>
      (select(medicamentoGruposTable)
            ..where((t) => t.medicamentoId.equals(medicamentoId)))
          .get();

  Future<void> toggleFavorito(String id, bool valor) async {
    await (update(medicamentosTable)..where((t) => t.id.equals(id)))
        .write(MedicamentosTableCompanion(esFavorito: Value(valor)));
  }

  Future<List<MedicamentosTableData>> getFavoritos() =>
      (select(medicamentosTable)
            ..where((t) => t.esFavorito.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.nombreComercial)]))
          .get();

  Future<List<HistorialTableData>> getHistorial({int limit = 50}) =>
      (select(historialTable)
            ..orderBy([(t) => OrderingTerm.desc(t.fecha)])
            ..limit(limit))
          .get();

  Future<void> insertHistorial(HistorialTableCompanion entry) =>
      into(historialTable).insertOnConflictUpdate(entry);

  Future<void> limpiarHistorial() => delete(historialTable).go();

  Future<String?> getSyncMeta(String clave) async {
    final row = await (select(syncMetaTable)
          ..where((t) => t.clave.equals(clave)))
        .getSingleOrNull();
    return row?.valor;
  }

  Future<void> setSyncMeta(String clave, String valor) async {
    await into(syncMetaTable).insertOnConflictUpdate(
      SyncMetaTableCompanion(
        clave: Value(clave),
        valor: Value(valor),
      ),
    );
  }

  // ── Valores únicos para filtros ─────────────────────────────────────────────
  Future<List<String>> getCategorias() async {
    final rows = await (select(medicamentosTable)
          ..where((t) => t.categoria.isNotNull()))
        .get();
    final set = <String>{};
    for (final r in rows) {
      if (r.categoria != null) set.add(r.categoria!);
    }
    return set.toList()..sort();
  }

  Future<List<String>> getPrincipiosActivos() async {
    final rows = await select(medicamentosTable).get();
    final set = <String>{};
    for (final r in rows) {
      for (final p in jsonToList(r.principiosActivos)) {
        set.add(p);
      }
    }
    return set.toList()..sort();
  }

  Future<List<String>> getFormasFarmaceuticas() async {
    final rows = await select(medicamentosTable).get();
    final set = <String>{};
    for (final r in rows) {
      for (final f in jsonToList(r.formasFarmaceuticas)) {
        set.add(f);
      }
    }
    return set.toList()..sort();
  }

  Future<List<String>> getViasAdministracion() async {
    final rows = await select(medicamentosTable).get();
    final set = <String>{};
    for (final r in rows) {
      for (final v in jsonToList(r.viasAdministracion)) {
        set.add(v);
      }
    }
    return set.toList()..sort();
  }

  Future<List<String>> getLaboratorios() async {
    final rows = await select(medicamentosTable).get();
    final set = <String>{};
    for (final r in rows) {
      for (final l in jsonToList(r.laboratorios)) {
        set.add(l);
      }
    }
    return set.toList()..sort();
  }
}