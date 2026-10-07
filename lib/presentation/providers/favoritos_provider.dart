import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';

final favoritosProvider =
    FutureProvider<List<MedicamentosTableData>>((ref) async {
  final dao = ref.watch(medicamentosDaoProvider);
  return dao.getFavoritos();
});