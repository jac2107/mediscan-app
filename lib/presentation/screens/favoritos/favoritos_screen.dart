import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicamentos_app/core/theme/app_theme.dart';
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
      appBar: AppBar(
        title: Text('Favoritos',
            style: GoogleFonts.lora(fontSize: 20, color: AppTheme.ink)),
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
                  Text('Sin favoritos',
                      style: GoogleFonts.lora(fontSize: 21, color: AppTheme.ink)),
                  const SizedBox(height: 6),
                  Text(
                    'Marca el ★ en una ficha para acceder rápido.',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.muted),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: lista.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 24),
            itemBuilder: (context, index) {
              final med = lista[index];
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                title: Text(med.nombreComercial),
                subtitle: med.descripcion != null
                    ? Text(med.descripcion!,
                        maxLines: 1, overflow: TextOverflow.ellipsis)
                    : null,
                trailing: GestureDetector(
                  onTap: () async {
                    await ref
                        .read(appDatabaseProvider)
                        .toggleFavorito(med.id, false);
                    ref.invalidate(favoritosProvider);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.star_rounded,
                        size: 18, color: AppTheme.colorWarn),
                  ),
                ),
                onTap: () => context.push(
                    Routes.detalleMedicamento.replaceAll(':id', med.id)),
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
          padding: const EdgeInsets.all(24),
          child: Text('Error: $e'),
        ),
      ),
    );
  }
}