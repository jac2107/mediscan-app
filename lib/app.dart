// app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/sync_provider.dart';
import 'presentation/router/app_router.dart';

class MedicamentosApp extends ConsumerWidget {
  final bool sincronizar;
  const MedicamentosApp({super.key, this.sincronizar = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (sincronizar) {
      ref.watch(syncProvider);
    }
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Farmafolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
