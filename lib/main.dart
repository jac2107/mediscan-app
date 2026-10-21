import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'data/local/database/app_database.dart';
import 'data/local/seed/seed_loader.dart';
import 'presentation/screens/inicio/inicio_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: InicioApp(inicializar: inicializarAplicacion)));
}

Future<void>? _backend;
Future<void> _inicializarBackend() async {
  await Supabase.initialize(
    url: 'https://qnpiibqbosbxqbopcnyk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFucGlpYnFib3NieHFib3BjbnlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTIwMDc3MDgsImV4cCI6MjEwNzU4MzcwOH0.9vNAGjWRwtDsa014mvsvxB-A77W9PQM_Rx3nLdLHsJk',
  );
}

Future<ResultadoInicio> inicializarAplicacion() async {
  final db = AppDatabase();
  try {
    await SeedLoader(db).cargarSiVacio();
  } finally {
    await db.close();
  }
  try {
    _backend ??= _inicializarBackend().catchError((Object e) {
      _backend = null;
      throw e;
    });
    await _backend!.timeout(const Duration(seconds: 12));
    return const ResultadoInicio();
  } catch (_) {
    return const ResultadoInicio(remotoDisponible: false);
  }
}
