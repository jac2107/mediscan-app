import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medicamentos_app/data/remote/supabase/audit_remote.dart';
import 'package:medicamentos_app/presentation/providers/connectivity_provider.dart';

final auditLogsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final remote = AuditRemote();
  return remote.getLogs();
});

class AuditLogScreen extends ConsumerWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final conectadoAsync = ref.watch(isConnectedProvider);
    final fmt = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(auditLogsProvider),
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: conectadoAsync.when(
        data: (online) {
          if (!online) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_off_rounded,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sin conexión',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'El audit log requiere internet\npara mostrarse',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          final logsAsync = ref.watch(auditLogsProvider);
          return logsAsync.when(
            data: (logs) {
              if (logs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 64,
                        color: theme.colorScheme.onSurfaceVariant
                            .withOpacity(0.4),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Sin registros aún',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: logs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final log = logs[index];
                  final accion = log['accion'] as String? ?? '';
                  final usuario = log['usuario_nombre'] as String? ?? '?';
                  final fecha = log['fecha'] != null
                      ? DateTime.tryParse(log['fecha'] as String)
                      : null;

                  final color = switch (accion) {
                    'CREAR' => Colors.green,
                    'EDITAR' => Colors.blue,
                    'ELIMINAR' => Colors.red,
                    _ => Colors.grey,
                  };

                  final icono = switch (accion) {
                    'CREAR' => Icons.add_circle_outline_rounded,
                    'EDITAR' => Icons.edit_outlined,
                    'ELIMINAR' => Icons.delete_outline_rounded,
                    _ => Icons.info_outline_rounded,
                  };

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(icono, color: color, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        accion,
                                        style: TextStyle(
                                          color: color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        log['tabla'] as String? ?? '',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.person_outline,
                                        size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      usuario,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                if (fecha != null) ...[
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_rounded,
                                          size: 14),
                                      const SizedBox(width: 4),
                                      Text(
                                        fmt.format(fecha),
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                                if (log['datos_despues'] != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Nombre: ${(log['datos_despues'] as Map)['nombre'] ?? ''}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color:
                                          theme.colorScheme.onSurfaceVariant,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text('Error al cargar logs: $e'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => ref.invalidate(auditLogsProvider),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Error de conectividad')),
      ),
    );
  }
}