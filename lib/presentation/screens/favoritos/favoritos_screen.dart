import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medicamentos_app/presentation/providers/favoritos_provider.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';

class FavoritosScreen extends ConsumerWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favoritosAsync = ref.watch(favoritosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: favoritosAsync.when(
        data: (lista) {
          if (lista.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_outline_rounded,
                    size: 72,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Aún no tienes favoritos',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Marca el ★ en un medicamento\npara tenerlo a la mano',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
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
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final med = lista[index];
              return Card(
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                  ),
                  title: Text(
                    med.nombre,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: med.descripcion != null
                      ? Text(
                          med.descripcion!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.star_rounded, color: Colors.amber),
                    onPressed: () async {
                      final dao = ref.read(medicamentosDaoProvider);
                      await dao.toggleFavorito(med.id, false);
                      ref.invalidate(favoritosProvider);
                    },
                    tooltip: 'Quitar de favoritos',
                  ),
                  onTap: () => context.push(
                    Routes.detalleMedicamento.replaceAll(':id', med.id),
                  ),
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