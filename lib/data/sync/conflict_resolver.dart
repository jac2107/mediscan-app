import 'package:medicamentos_app/data/local/database/app_database.dart';

class ConflictResolver {
  // Estrategia: last-write-wins por fecha de actualización
  // Si el registro remoto es más nuevo, gana el remoto
  // Si el local es más nuevo, gana el local
  MedicamentosTableData resolver({
    required MedicamentosTableData local,
    required MedicamentosTableData remoto,
  }) {
    if (remoto.actualizadoEn.isAfter(local.actualizadoEn)) {
      return remoto;
    }
    return local;
  }

  // Para listas: merge sin duplicados
  List<String> mergeListas(List<String> local, List<String> remota) {
    final set = {...local, ...remota};
    return set.toList();
  }
}