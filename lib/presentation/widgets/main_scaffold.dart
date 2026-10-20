import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  int _indexActual(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/favoritos')) return 1;
    if (location.startsWith('/historial')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final idx = _indexActual(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          NavigationBar(
            backgroundColor: AppTheme.bgMarfil,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            selectedIndex: idx,
            onDestinationSelected: (i) {
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
    );
  }
}
