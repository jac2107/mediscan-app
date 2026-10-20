import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/sync_provider.dart';
import '../../providers/connectivity_provider.dart';

class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncProvider);
    final sync = ref.watch(isConnectedProvider).valueOrNull == false
        ? EstadoSync.offline
        : syncState;
    final (label, icon, color) = switch (sync) {
      EstadoSync.sincronizando => (
          'Actualizando…',
          Icons.sync_outlined,
          AppTheme.muted,
        ),
      EstadoSync.actualizado => (
          'Catálogo actualizado',
          Icons.check_circle_outline,
          AppTheme.verde,
        ),
      EstadoSync.offline => (
          'Sin conexión',
          Icons.wifi_off_outlined,
          AppTheme.muted,
        ),
      EstadoSync.error => (
          'No pudimos actualizar',
          Icons.error_outline,
          AppTheme.colorError,
        ),
      _ => ('Catálogo local', Icons.inventory_2_outlined, AppTheme.muted),
    };
    return Tooltip(
      message: label,
      child: Semantics(
        label: label,
        liveRegion: true,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: sync == EstadoSync.sincronizando
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.muted,
                  ),
                )
              : Icon(icon, size: 22, color: color),
        ),
      ),
    );
  }
}
