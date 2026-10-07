import 'package:medicamentos_app/core/constants/supabase_constants.dart';
import 'package:medicamentos_app/data/remote/supabase/supabase_service.dart';

class AuditRemote {
  final _client = SupabaseService.client;

  Future<void> registrar(Map<String, dynamic> data) async {
    await _client.from(SupabaseConstants.tablaAuditLog).insert(data);
  }

  Future<List<Map<String, dynamic>>> getLogs() async {
    final response = await _client
        .from(SupabaseConstants.tablaAuditLog)
        .select()
        .order('fecha', ascending: false)
        .limit(100);
    return List<Map<String, dynamic>>.from(response);
  }
}