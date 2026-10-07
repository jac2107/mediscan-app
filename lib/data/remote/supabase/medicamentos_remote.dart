import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medicamentos_app/core/constants/supabase_constants.dart';
import 'package:medicamentos_app/data/remote/supabase/supabase_service.dart';

class MedicamentosRemote {
  final _client = SupabaseService.client;

  Future<List<Map<String, dynamic>>> getAll() async {
    final response = await _client
        .from(SupabaseConstants.tablaMedicamentos)
        .select()
        .eq('eliminado', false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> upsert(Map<String, dynamic> data) async {
    await _client
        .from(SupabaseConstants.tablaMedicamentos)
        .upsert(data, onConflict: 'id');
  }

  Future<void> eliminar(String id) async {
    await _client
        .from(SupabaseConstants.tablaMedicamentos)
        .update({
          'eliminado': true,
          'actualizado_en': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  void escucharCambios({
    required void Function(Map<String, dynamic> payload) onInsert,
    required void Function(Map<String, dynamic> payload) onUpdate,
    required void Function(Map<String, dynamic> payload) onDelete,
  }) {
    _client
        .channel('medicamentos_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: SupabaseConstants.tablaMedicamentos,
          callback: (payload) => onInsert(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: SupabaseConstants.tablaMedicamentos,
          callback: (payload) => onUpdate(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: SupabaseConstants.tablaMedicamentos,
          callback: (payload) => onDelete(payload.oldRecord),
        )
        .subscribe();
  }
}