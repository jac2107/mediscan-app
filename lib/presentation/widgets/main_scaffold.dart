import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/voz_provider.dart';
import '../../core/theme/app_theme.dart';

class MainScaffold extends ConsumerWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  int _indexActual(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/favoritos')) return 1;
    if (location.startsWith('/historial')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = _indexActual(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NavigationBar(
                  backgroundColor: AppTheme.surface,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  selectedIndex: idx,
                  onDestinationSelected: (i) {
                    if (i != 0) {
                      ref.read(vozProvider.notifier).cancelar();
                    }
                    switch (i) {
                      case 0:
                        context.go('/');
                      case 1:
                        context.go('/favoritos');
                      case 2:
                        context.go('/historial');
                    }
                  },
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(Icons.search_rounded),
                      selectedIcon: const Icon(
                        Icons.search_rounded,
                        color: AppTheme.verde,
                      ),
                      label: 'Catálogo',
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.star_outline_rounded),
                      selectedIcon: const Icon(
                        Icons.star_rounded,
                        color: AppTheme.verde,
                      ),
                      label: 'Favoritos',
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.history_rounded),
                      selectedIcon: const Icon(
                        Icons.history_rounded,
                        color: AppTheme.verde,
                      ),
                      label: 'Historial',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
