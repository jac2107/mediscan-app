import 'package:drift/drift.dart';
import '../database/app_database.dart';

part 'sync_queue_dao.g.dart';

@DriftAccessor(tables: [SyncQueueTable])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<List<SyncQueueTableData>> getPendientes() {
    return (select(syncQueueTable)
          ..where((s) => s.sincronizado.equals(false))
          ..orderBy([(s) => OrderingTerm.asc(s.creadoEn)]))
        .get();
  }

  Future<void> agregar(SyncQueueTableCompanion entry) {
    return into(syncQueueTable).insert(entry);
  }

  Future<void> marcarSincronizado(String id) {
    return (update(syncQueueTable)..where((s) => s.id.equals(id))).write(
      const SyncQueueTableCompanion(sincronizado: Value(true)),
    );
  }
}