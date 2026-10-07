import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/data/local/daos/historial_dao.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';

final historialDaoProvider = Provider<HistorialDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.historialDao;
});

final historialProvider =
    FutureProvider<List<HistorialTableData>>((ref) async {
  final dao = ref.watch(historialDaoProvider);
  return dao.getRecientes();
});