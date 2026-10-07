import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medicamentos_app/core/constants/supabase_constants.dart';

class SupabaseService {
  SupabaseService._();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConstants.supabaseUrl,
      anonKey: SupabaseConstants.supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}