import 'dart:convert';
import 'package:drift/drift.dart';
import '../local/database/app_database.dart';

/// Única conversión del contrato público de Supabase a la caché local.
class MedicamentoModel {
  static MedicamentosTableCompanion toCompanion(
    Map<String, dynamic> p, {
    required String Function(String path) publicImageUrl,
  }) {
    String? fotoUrl;
    final raw = p['foto_path'] as String?;
    if (raw != null && raw.isNotEmpty) {
      fotoUrl = raw.startsWith('http') ? raw : publicImageUrl(raw);
    } else {
      final sources = p['medicamento_fuentes'];
      if (sources is Map) {
        fotoUrl = sources['imagen_origen_url'] as String?;
      } else if (sources is List) {
        for (final source in sources) {
          if (source is Map && source['imagen_origen_url'] is String &&
              (source['imagen_origen_url'] as String).isNotEmpty) {
            fotoUrl = source['imagen_origen_url'] as String;
            break;
          }
        }
      }
    }
    String array(dynamic value) {
      if (value == null) return '[]';
      if (value is! List || value.any((item) => item is! String)) {
        throw const FormatException('Se esperaba un arreglo de textos del catálogo.');
      }
      return jsonEncode(value);
    }
    final category = p['categoria'];
    return MedicamentosTableCompanion(
      id: Value(p['id'] as String),
      codigoInterno: Value(p['codigo_interno'] as String),
      nombreComercial: Value(p['nombre_comercial'] as String),
      nombreGenerico: Value(p['nombre_generico'] as String?),
      categoria: Value(category is List ? jsonEncode(category) : category as String?),
      laboratorios: Value(array(p['laboratorios'])),
      descripcion: Value(p['descripcion'] as String?),
      principiosActivos: Value(array(p['principios_activos'])),
      composicionCompleta: Value(p['composicion_completa'] as String?),
      concentraciones: Value(array(p['concentraciones'])),
      formasFarmaceuticas: Value(array(p['formas_farmaceuticas'])),
      presentacion: Value(p['presentacion'] as String?),
      viasAdministracion: Value(array(p['vias_administracion'])),
      indicacionesTexto: Value(p['indicaciones_texto'] as String?),
      indicacionesTags: Value(array(p['indicaciones_tags'])),
      contraindicaciones: Value(p['contraindicaciones'] as String?),
      precaucionesAdvertencias: Value(p['precauciones_advertencias'] as String?),
      efectosAdversos: Value(p['efectos_adversos'] as String?),
      dosisAdultos: Value(p['dosis_adultos'] as String?),
      dosisAdultosMayores: Value(p['dosis_adultos_mayores'] as String?),
      dosisPediatrica: Value(p['dosis_pediatrica'] as String?),
      dosisLactantes: Value(p['dosis_lactantes'] as String?),
      fotoUrl: Value(fotoUrl),
      fechaRevision: Value(p['fecha_revision'] as String?),
      actualizadoEn: Value(p['actualizado_en'] as String?),
      // Ausente: preserva favoritos al actualizar una ficha existente.
    );
  }
}
