import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicamentos_app/core/theme/app_theme.dart';
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
        title: Text('Historial',
            style: GoogleFonts.lora(fontSize: 20, color: AppTheme.ink)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined, size: 20),
            tooltip: 'Limpiar historial',
            onPressed: () async {
            final confirmar = await showDialog<bool>(
              context: context,
              useRootNavigator: true,
              builder: (dialogContext) => AlertDialog(
              title: Text('Limpiar historial',
                  style: GoogleFonts.lora(fontSize: 18, color: AppTheme.ink)),
              content: Text(
                '¿Eliminar todo el historial de búsquedas?',
                style: GoogleFonts.inter(fontSize: 14, color: AppTheme.ink),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Cancelar')),
                FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text('Limpiar')),
              ],
            ),
            );
            if (confirmar == true) {
              await ref.read(appDatabaseProvider).limpiarHistorial();
              ref.invalidate(historialProvider);
            }
          },
          ),
        ],
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1), child: Divider(height: 1)),
      ),
      body: historialAsync.when(
        data: (lista) {
          if (lista.isEmpty) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sin historial',
                      style: GoogleFonts.lora(fontSize: 21, color: AppTheme.ink)),
                  const SizedBox(height: 6),
                  Text(
                    'Las búsquedas y escaneos aparecerán aquí.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: lista.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 24),
            itemBuilder: (context, index) {
              final item = lista[index];
              final esEscaneo = item.tipo == 'escaneo';
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                leading: Icon(
                  esEscaneo
                      ? Icons.qr_code_scanner_rounded
                      : Icons.search_rounded,
                  size: 18,
                  color: AppTheme.muted,
                ),
                title: Text(item.nombreSnapshot),
                subtitle: Text(
                  '${esEscaneo ? 'Escaneado' : 'Buscado'} · ${fmt.format(item.fecha)}',
                ),
                trailing: const Icon(Icons.chevron_right_rounded,
                    size: 16, color: AppTheme.border),
                onTap: () async {
                  final db = ref.read(appDatabaseProvider);
                  final med = await db.getMedicamentoById(item.medicamentoId);
                  if (med != null && context.mounted) {
                    context.push(Routes.detalleMedicamento
                        .replaceAll(':id', item.medicamentoId));
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Medicamento ya no existe'),
                    ));
                  }
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppTheme.verde)),
        ),
        error: (e, _) => Padding(
            padding: const EdgeInsets.all(24), child: Text('Error: $e')),
      ),
    );
  }
}