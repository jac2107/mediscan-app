import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medicamentos_app/presentation/providers/historial_provider.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';

class HistorialScreen extends ConsumerWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final historialAsync = ref.watch(historialProvider);
    final fmt = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            tooltip: 'Limpiar historial',
            onPressed: () async {
              final confirmar = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Limpiar historial'),
                  content: const Text(
                      '¿Deseas eliminar todo el historial de búsquedas?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
              );
              if (confirmar == true) {
                final dao = ref.read(historialDaoProvider);
                await dao.limpiar();
                ref.invalidate(historialProvider);
              }
            },
          ),
        ],
      ),
      body: historialAsync.when(
        data: (lista) {
          if (lista.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 72,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sin historial aún',
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
            itemCount: lista.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final item = lista[index];
              final esEscaneo = item.tipo == 'escaneo';

              return Card(
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: esEscaneo
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      esEscaneo
                          ? Icons.qr_code_scanner_rounded
                          : Icons.search_rounded,
                      color: esEscaneo ? Colors.blue : Colors.grey,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    item.medicamentoNombre,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    '${esEscaneo ? 'Escaneado' : 'Buscado'} — ${fmt.format(item.fecha)}',
                    style: theme.textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () async {
                    final dao = ref.read(medicamentosDaoProvider);
                    final todos = await dao.getAll();
                    try {
                      todos.firstWhere((m) => m.id == item.medicamentoId);
                      if (context.mounted) {
                        context.push(
                          Routes.detalleMedicamento
                              .replaceAll(':id', item.medicamentoId),
                        );
                      }
                    } catch (_) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Medicamento ya no existe'),
                          ),
                        );
                      }
                    }
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}