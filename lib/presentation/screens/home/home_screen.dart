import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medicamentos_app/presentation/providers/usuario_provider.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';
import 'package:medicamentos_app/presentation/widgets/common/sync_indicator.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final usuarioAsync = ref.watch(usuarioNombreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MediScan'),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: SyncIndicator(),
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            tooltip: 'Audit log',
            onPressed: () => context.push(Routes.auditLog),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Saludo
              usuarioAsync.when(
                data: (nombre) => Text(
                  'Hola, $nombre 👋',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 4),
              Text(
                'Consulta o escanea un medicamento',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),

              // Buscador principal
              GestureDetector(
                onTap: () => context.push(Routes.buscador),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Buscar medicamento...',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Botón escáner
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: () => context.push(Routes.scanner),
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: const Text(
                    'Escanear código de barras',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Accesos rápidos
              Text(
                'Accesos rápidos',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _AccesoRapido(
                      icon: Icons.star_rounded,
                      label: 'Favoritos',
                      color: Colors.amber,
                      onTap: () => context.push(Routes.favoritos),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AccesoRapido(
                      icon: Icons.history_rounded,
                      label: 'Historial',
                      color: Colors.blue,
                      onTap: () => context.push(Routes.historial),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AccesoRapido(
                      icon: Icons.add_circle_rounded,
                      label: 'Agregar',
                      color: Colors.green,
                      onTap: () => context.push(Routes.formularioMedicamento),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccesoRapido extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AccesoRapido({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}