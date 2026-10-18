
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/core/network/connectivity_service.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final isConnectedProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(connectivityServiceProvider);
  return service.isConnected();
});
