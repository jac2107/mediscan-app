import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';
import 'package:medicamentos_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:medicamentos_app/presentation/screens/home/home_screen.dart';
import 'package:medicamentos_app/presentation/screens/medicamento/medicamento_detail_screen.dart';
import 'package:medicamentos_app/presentation/screens/medicamento/medicamento_form_screen.dart';
import 'package:medicamentos_app/presentation/screens/scanner/scanner_screen.dart';
import 'package:medicamentos_app/presentation/screens/favoritos/favoritos_screen.dart';
import 'package:medicamentos_app/presentation/screens/historial/historial_screen.dart';
import 'package:medicamentos_app/presentation/screens/admin/audit_log_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicamentos_app/presentation/screens/buscador/buscador_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.home,
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final onboardingDone = prefs.getBool('onboarding_done') ?? false;
      if (!onboardingDone && state.matchedLocation != Routes.onboarding) {
        return Routes.onboarding;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.formularioMedicamento,
        builder: (context, state) {
          final medicamentoId = state.uri.queryParameters['id'];
          final codigo = state.uri.queryParameters['codigo'];
          return MedicamentoFormScreen(
            medicamentoId: medicamentoId,
            codigoInicial: codigo,
          );
        },
      ),
      GoRoute(
        path: Routes.buscador,
        builder: (context, state) => const BuscadorScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.detalleMedicamento,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MedicamentoDetailScreen(medicamentoId: id);
        },
      ),
      GoRoute(
        path: Routes.formularioMedicamento,
        builder: (context, state) {
          final medicamentoId = state.uri.queryParameters['id'];
          return MedicamentoFormScreen(medicamentoId: medicamentoId);
        },
      ),
      GoRoute(
        path: Routes.scanner,
        builder: (context, state) => const ScannerScreen(),
      ),
      GoRoute(
        path: Routes.favoritos,
        builder: (context, state) => const FavoritosScreen(),
      ),
      GoRoute(
        path: Routes.historial,
        builder: (context, state) => const HistorialScreen(),
      ),
      GoRoute(
        path: Routes.auditLog,
        builder: (context, state) => const AuditLogScreen(),
      ),
    ],
  );
});