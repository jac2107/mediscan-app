import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/catalogo/catalogo_screen.dart';
import '../screens/medicamento/medicamento_detail_screen.dart';
import '../screens/favoritos/favoritos_screen.dart';
import '../screens/historial/historial_screen.dart';
import '../widgets/main_scaffold.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: CatalogoScreen()),
          ),
          GoRoute(
            path: '/favoritos',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: FavoritosScreen()),
          ),
          GoRoute(
            path: '/historial',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: HistorialScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/medicamento/:id',
        builder: (context, state) =>
            MedicamentoDetailScreen(medicamentoId: state.pathParameters['id']!),
      ),
    ],
  ),
);
