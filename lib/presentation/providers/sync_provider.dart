import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/remote/supabase/medicamentos_remote.dart';
import '../../data/repositories/medicamento_repository_impl.dart';
import 'medicamentos_provider.dart';
import 'connectivity_provider.dart';

enum EstadoSync { idle, sincronizando, actualizado, error, offline }

class SyncNotifier extends Notifier<EstadoSync> with WidgetsBindingObserver {
  Timer? _timer;
  Timer? _initial;
  bool _running = false;
  bool _pending = false;
  bool _disposed = false;

  @override
  EstadoSync build() {
    _disposed = false;
    _initial = Timer(
      const Duration(seconds: 3),
      () => unawaited(_sincronizar()),
    );
    ref.listen(isConnectedProvider, (prev, next) {
      next.whenData((online) {
        if (online && prev?.value == false) unawaited(_sincronizar());
      });
    });
    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => unawaited(_sincronizar()),
    );
    WidgetsBinding.instance.addObserver(this);
    final client = Supabase.instance.client;
    final channel = client
        .channel('medicamentos_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'medicamentos',
          callback: (_) => unawaited(_sincronizar()),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'catalog_changes',
          callback: (_) => unawaited(_sincronizar()),
        )
        .subscribe();
    ref.onDispose(() {
      _disposed = true;
      _initial?.cancel();
      _timer?.cancel();
      WidgetsBinding.instance.removeObserver(this);
      unawaited(client.removeChannel(channel));
    });
    return EstadoSync.idle;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    if (lifecycle == AppLifecycleState.resumed) unawaited(_sincronizar());
  }

  Future<void> _sincronizar() async {
    if (_disposed) return;
    if (_running) {
      _pending = true;
      return;
    }
    _running = true;
    try {
      do {
        _pending = false;
        if (_disposed) return;
        state = EstadoSync.sincronizando;
        final db = ref.read(appDatabaseProvider);
        final remote = MedicamentosRemote(client: Supabase.instance.client);
        // Una instantánea actual evita resucitar eliminados con eventos antiguos,
        // omitir fichas iniciales o perder eventos por el orden de commit del cursor.
        await MedicamentoRepositoryImpl(db: db, remote: remote).sincronizar();
        if (_disposed) return;
        ref.invalidate(todosMedicamentosProvider);
        ref.invalidate(favoritosProvider);
        ref.invalidate(medicamentoPorIdProvider);
        state = EstadoSync.actualizado;
      } while (_pending && !_disposed);
    } catch (error, stack) {
      debugPrint('No se pudo sincronizar el catálogo: $error\n$stack');
      if (!_disposed) {
        state = ref.read(isConnectedProvider).value == false
            ? EstadoSync.offline
            : EstadoSync.error;
      }
    } finally {
      _running = false;
    }
  }

  void syncManual() => unawaited(_sincronizar());
}

final syncProvider = NotifierProvider<SyncNotifier, EstadoSync>(
  SyncNotifier.new,
);
