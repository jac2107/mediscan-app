import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/core/network/connectivity_service.dart';
import 'package:medicamentos_app/data/remote/supabase/audit_remote.dart';
import 'package:medicamentos_app/data/remote/supabase/medicamentos_remote.dart';
import 'package:medicamentos_app/data/sync/sync_manager.dart';
import 'package:medicamentos_app/presentation/providers/connectivity_provider.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';

final medicamentosRemoteProvider = Provider<MedicamentosRemote>((ref) {
  return MedicamentosRemote();
});

final auditRemoteProvider = Provider<AuditRemote>((ref) {
  return AuditRemote();
});

final syncManagerProvider = Provider<SyncManager>((ref) {
  return SyncManager(
    db: ref.watch(appDatabaseProvider),
    remote: ref.watch(medicamentosRemoteProvider),
    auditRemote: ref.watch(auditRemoteProvider),
    connectivity: ref.watch(connectivityServiceProvider),
  );
});

// Se llama al iniciar la app para sincronizar
final syncInicialProvider = FutureProvider<void>((ref) async {
  final syncManager = ref.watch(syncManagerProvider);
  await syncManager.sincronizarInicial();
  await syncManager.subirPendientes();
  syncManager.escucharRealtime();
});

// Escucha cambios de conectividad y sincroniza automáticamente
final autoSyncProvider = StreamProvider<void>((ref) async* {
  final connectivity = ref.watch(connectivityServiceProvider);
  await for (final online in connectivity.onConnectivityChanged) {
    if (online) {
      final syncManager = ref.watch(syncManagerProvider);
      await syncManager.subirPendientes();
      ref.invalidate(medicamentosRemoteProvider);
    }
  }
});