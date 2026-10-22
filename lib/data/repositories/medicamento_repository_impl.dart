import '../models/medicamento_model.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/remote/supabase/medicamentos_remote.dart';
import 'package:medicamentos_app/domain/entities/medicamento.dart';
import 'package:medicamentos_app/domain/repositories/medicamento_repository.dart';

class MedicamentoRepositoryImpl implements MedicamentoRepository {
  final AppDatabase _db;
  final MedicamentosRemote _remote;

  MedicamentoRepositoryImpl({
    required AppDatabase db,
    required MedicamentosRemote remote,
  })  : _db = db,
        _remote = remote;

  Medicamento _fromRow(MedicamentosTableData d) => Medicamento(
        id: d.id,
        codigoInterno: d.codigoInterno,
        nombreComercial: d.nombreComercial,
        nombreGenerico: d.nombreGenerico,
        categoria: d.categoria,
        laboratorios: AppDatabase.jsonToList(d.laboratorios),
        descripcion: d.descripcion,
        principiosActivos: AppDatabase.jsonToList(d.principiosActivos),
        composicionCompleta: d.composicionCompleta,
        concentraciones: AppDatabase.jsonToList(d.concentraciones),
        formasFarmaceuticas: AppDatabase.jsonToList(d.formasFarmaceuticas),
        presentacion: d.presentacion,
        viasAdministracion: AppDatabase.jsonToList(d.viasAdministracion),
        indicacionesTexto: d.indicacionesTexto,
        indicacionesTags: AppDatabase.jsonToList(d.indicacionesTags),
        contraindicaciones: d.contraindicaciones,
        precaucionesAdvertencias: d.precaucionesAdvertencias,
        efectosAdversos: d.efectosAdversos,
        dosisAdultos: d.dosisAdultos,
        dosisAdultosMayores: d.dosisAdultosMayores,
        dosisPediatrica: d.dosisPediatrica,
        dosisLactantes: d.dosisLactantes,
        fotoUrl: d.fotoUrl,
        fechaRevision: d.fechaRevision,
        actualizadoEn: d.actualizadoEn,
        esFavorito: d.esFavorito,
      );

  @override
  Future<List<Medicamento>> getAll() async {
    final rows = await _db.getAllMedicamentos();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<Medicamento?> getById(String id) async {
    final row = await _db.getMedicamentoById(id);
    return row != null ? _fromRow(row) : null;
  }

  @override
  Future<List<Medicamento>> getFavoritos() async {
    final rows = await _db.getFavoritos();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<void> toggleFavorito(String id, bool valor) =>
      _db.toggleFavorito(id, valor);

  @override
  Future<void> sincronizar() async {
    // Un error no sustituye la caché por una lista vacía.
    final rows = await _remote.getAll();
    final companions = rows.map((row) => MedicamentoModel.toCompanion(
      row, publicImageUrl: _remote.publicImageUrl,
    )).toList();
    await _db.aplicarCatalogoPublico(companions);
  }
}
