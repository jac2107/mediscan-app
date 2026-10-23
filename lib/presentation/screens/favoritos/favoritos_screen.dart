import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medicamentos_app/core/theme/app_fonts.dart';
import 'package:medicamentos_app/core/theme/app_theme.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';
import '../../widgets/medicamento/medicamento_card.dart';

class FavoritosScreen extends ConsumerWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favoritosAsync = ref.watch(favoritosProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoritos',
          style: AppFonts.lora(fontSize: 28, color: AppTheme.ink),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: favoritosAsync.when(
        data: (lista) {
          if (lista.isEmpty) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sin favoritos',
                    style: AppFonts.lora(fontSize: 21, color: AppTheme.ink),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Toca la estrella de una ficha para guardarla aquí.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.muted,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: lista.length,
            separatorBuilder: (_, __) => const SizedBox.shrink(),
            itemBuilder: (context, index) {
              final med = lista[index];
              return MedicamentoCard(
                medicamento: med,
                onTap: () => context.push(
                  Routes.detalleMedicamento.replaceAll(':id', med.id),
                ),
                onFavoritoToggle: () async {
                  await ref
                      .read(appDatabaseProvider)
                      .toggleFavorito(med.id, false);
                  ref.invalidate(favoritosProvider);
                  ref.invalidate(todosMedicamentosProvider);
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
              strokeWidth: 2,
              color: AppTheme.verde,
            ),
          ),
        ),
        error: (e, _) => Padding(
          padding: const EdgeInsets.all(24),
          child: const Text(
            'No pudimos cargar tus favoritos. Vuelve a intentarlo.',
          ),
        ),
      ),
    );
  }
}
