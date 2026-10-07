import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/local/daos/medicamentos_dao.dart';

// Instancia única de la base de datos
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// DAO de medicamentos
final medicamentosDaoProvider = Provider<MedicamentosDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.medicamentosDao;
});

// Buscar por nombre (predictivo)
final busquedaQueryProvider = StateProvider<String>((ref) => '');

final sugerenciasProvider =
    FutureProvider<List<MedicamentosTableData>>((ref) async {
  final query = ref.watch(busquedaQueryProvider);
  final dao = ref.watch(medicamentosDaoProvider);
  if (query.trim().isEmpty) return [];
  return dao.buscarPorNombre(query);
});

// Todos los medicamentos
final todosMedicamentosProvider =
    FutureProvider<List<MedicamentosTableData>>((ref) async {
  final dao = ref.watch(medicamentosDaoProvider);
  return dao.getAll();
});

// Medicamento por ID
final medicamentoPorIdProvider =
    FutureProvider.family<MedicamentosTableData?, String>((ref, id) async {
  final dao = ref.watch(medicamentosDaoProvider);
  final todos = await dao.getAll();
  try {
    return todos.firstWhere((m) => m.id == id);
  } catch (_) {
    return null;
  }
});