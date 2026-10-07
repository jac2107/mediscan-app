import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/data/remote/supabase/supabase_service.dart';
import 'package:medicamentos_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const ProviderScope(child: MedicamentosApp()));
}