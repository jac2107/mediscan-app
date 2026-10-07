import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:medicamentos_app/data/local/daos/medicamentos_dao.dart';
import 'package:medicamentos_app/data/local/daos/historial_dao.dart';
import 'package:medicamentos_app/data/local/daos/sync_queue_dao.dart';

part 'app_database.g.dart';

class MedicamentosTable extends Table {
  TextColumn get id => text()();
  TextColumn get codigoBarras => text()();
  TextColumn get nombre => text()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get fotoUrl => text().nullable()();
  TextColumn get dosisAdulto => text().nullable()();
  TextColumn get dosisMayor => text().nullable()();
  TextColumn get dosisNino => text().nullable()();
  TextColumn get alergias => text().withDefault(const Constant('[]'))();
  TextColumn get contraindicaciones =>
      text().withDefault(const Constant('[]'))();
  TextColumn get enfermedadesIncompatibles =>
      text().withDefault(const Constant('[]'))();
  DateTimeColumn get actualizadoEn => dateTime()();
  BoolColumn get eliminado => boolean().withDefault(const Constant(false))();
  BoolColumn get esFavorito => boolean().withDefault(const Constant(false))();
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class HistorialTable extends Table {
  TextColumn get id => text()();
  TextColumn get medicamentoId => text()();
  TextColumn get medicamentoNombre => text()();
  TextColumn get tipo => text()();
  DateTimeColumn get fecha => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueueTable extends Table {
  TextColumn get id => text()();
  TextColumn get operacion => text()();
  DateTimeColumn get creadoEn => dateTime()();
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [MedicamentosTable, HistorialTable, SyncQueueTable],
  daos: [MedicamentosDao, HistorialDao, SyncQueueDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'medicamentos');
  }

  // Getters de los DAOs
  MedicamentosDao get medicamentosDao => MedicamentosDao(this);
  HistorialDao get historialDao => HistorialDao(this);
  SyncQueueDao get syncQueueDao => SyncQueueDao(this);

  static List<String> jsonToList(String json) {
    final decoded = jsonDecode(json) as List;
    return decoded.cast<String>();
  }

  static String listToJson(List<String> list) {
    return jsonEncode(list);
  }
}