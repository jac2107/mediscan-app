import 'package:medicamentos_app/domain/entities/medicamento.dart';

abstract class MedicamentoRepository {
  Future<List<Medicamento>> getAll();
  Future<Medicamento?> getById(String id);
  Future<List<Medicamento>> getFavoritos();
  Future<void> toggleFavorito(String id, bool valor);
  Future<void> sincronizar();
}