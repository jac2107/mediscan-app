import 'package:drift/drift.dart';
import '../database/app_database.dart';

part 'historial_dao.g.dart';

@DriftAccessor(tables: [HistorialTable])
class HistorialDao extends DatabaseAccessor<AppDatabase>
    with _$HistorialDaoMixin {
  HistorialDao(super.db);

  Future<List<HistorialTableData>> getRecientes() {
    return (select(historialTable)
          ..orderBy([(h) => OrderingTerm.desc(h.fecha)])
          ..limit(50))
        .get();
  }

  Future<void> agregar(HistorialTableCompanion entry) {
    return into(historialTable).insert(entry);
  }

  Future<void> limpiar() {
    return delete(historialTable).go();
  }
}