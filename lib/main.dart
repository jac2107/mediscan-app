import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'data/local/database/app_database.dart';
import 'data/local/seed/seed_loader.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qnpiibqbosbxqbopcnyk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFucGlpYnFib3NieHFib3BjbnlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTIwMDc3MDgsImV4cCI6MjEwNzU4MzcwOH0.9vNAGjWRwtDsa014mvsvxB-A77W9PQM_Rx3nLdLHsJk',
  );

  // Cargar seed si la BD está vacía
  final db = AppDatabase();
  await SeedLoader(db).cargarSiVacio();
  await db.close();

  runApp(const ProviderScope(child: MedicamentosApp()));
}