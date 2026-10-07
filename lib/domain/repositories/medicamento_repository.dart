import 'package:medicamentos_app/domain/entities/medicamento.dart';

abstract class MedicamentoRepository {
  Future<List<Medicamento>> getAll();
  Future<Medicamento?> buscarPorCodigo(String codigo);
  Future<List<Medicamento>> buscarPorNombre(String query);
  Future<List<Medicamento>> getFavoritos();
  Future<void> guardar(Medicamento medicamento, {required String usuarioNombre, required String dispositivoId});
  Future<void> eliminar(String id, {required String usuarioNombre, required String dispositivoId});
  Future<void> toggleFavorito(String id, bool valor);
  Future<void> sincronizar();
}