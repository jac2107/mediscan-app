import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

/// Android solo lee el catálogo publicado. Las escrituras pertenecen al panel.
class MedicamentosRemote {
  final SupabaseClient _client;
  MedicamentosRemote({SupabaseClient? client})
      : _client = client ?? SupabaseService.client;

  Future<List<Map<String, dynamic>>> getAll() async {
    final response = await _client.rpc('catalogo_medicamentos_app');
    if (response is! List) {
      throw const FormatException('No se recibió una instantánea válida del catálogo.');
    }
    return response.map((row) => Map<String, dynamic>.from(row as Map)).toList();
  }

  String publicImageUrl(String path) => _client.storage
      .from('medicamentos-publicos').getPublicUrl(path);
}
