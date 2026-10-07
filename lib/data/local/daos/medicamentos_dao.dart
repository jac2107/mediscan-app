import 'package:drift/drift.dart';
import 'package:medicamentos_app/core/constants/app_constants.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';

part 'medicamentos_dao.g.dart';

@DriftAccessor(tables: [MedicamentosTable])
class MedicamentosDao extends DatabaseAccessor<AppDatabase>
    with _$MedicamentosDaoMixin {
  MedicamentosDao(super.db);

  Future<List<MedicamentosTableData>> getAll() {
    return (select(medicamentosTable)
          ..where((m) => m.eliminado.equals(false)))
        .get();
  }

  Future<List<MedicamentosTableData>> buscarPorNombre(String query) {
    return (select(medicamentosTable)
          ..where((m) =>
              m.nombre.lower().like('%${query.toLowerCase()}%') &
              m.eliminado.equals(false))
          ..orderBy([(m) => OrderingTerm.asc(m.nombre)])
          ..limit(AppConstants.maxSugerencias))
        .get();
  }

  Future<MedicamentosTableData?> buscarPorCodigo(String codigo) {
    return (select(medicamentosTable)
          ..where((m) =>
              m.codigoBarras.equals(codigo) & m.eliminado.equals(false)))
        .getSingleOrNull();
  }

  Future<List<MedicamentosTableData>> getFavoritos() {
    return (select(medicamentosTable)
          ..where((m) =>
              m.esFavorito.equals(true) & m.eliminado.equals(false)))
        .get();
  }

  Future<void> upsert(MedicamentosTableCompanion entry) {
    return into(medicamentosTable).insertOnConflictUpdate(entry);
  }

  Future<void> toggleFavorito(String id, bool valor) {
    return (update(medicamentosTable)..where((m) => m.id.equals(id)))
        .write(MedicamentosTableCompanion(esFavorito: Value(valor)));
  }

  Future<void> eliminar(String id) {
    return (update(medicamentosTable)..where((m) => m.id.equals(id))).write(
      MedicamentosTableCompanion(
        eliminado: const Value(true),
        sincronizado: const Value(false),
      ),
    );
  }

  Future<List<MedicamentosTableData>> getNoSincronizados() {
    return (select(medicamentosTable)
          ..where((m) => m.sincronizado.equals(false)))
        .get();
  }

  Future<void> marcarSincronizado(String id) {
    return (update(medicamentosTable)..where((m) => m.id.equals(id))).write(
      const MedicamentosTableCompanion(sincronizado: Value(true)),
    );
  }
}