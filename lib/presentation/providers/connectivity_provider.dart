import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:medicamentos_app/core/network/connectivity_service.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final isConnectedProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  yield (await connectivity.checkConnectivity()).any(
    (r) => r != ConnectivityResult.none,
  );
  yield* connectivity.onConnectivityChanged
      .map((results) => results.any((r) => r != ConnectivityResult.none))
      .distinct();
});
