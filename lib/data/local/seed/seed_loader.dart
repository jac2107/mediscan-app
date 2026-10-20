import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import '../database/app_database.dart';

class SeedLoader {
  final AppDatabase _db;

  SeedLoader(this._db);

  Future<void> cargarSiVacio() async {
    // Solo carga si la BD está vacía
    final total = await _db.getAllMedicamentos();
    if (total.isNotEmpty) return;

    final jsonStr = await rootBundle.loadString(
      'assets/data/seed_medicamentos.json',
    );
    final List<dynamic> lista = jsonDecode(jsonStr);

    for (final item in lista) {
      final m = item as Map<String, dynamic>;

      await _db.upsertMedicamento(
        MedicamentosTableCompanion(
          id: Value(m['id'] as String),
          codigoInterno: Value(m['codigo_interno'] as String),
          nombreComercial: Value(m['nombre_comercial'] as String),
          nombreGenerico: Value(m['nombre_generico'] as String?),
          categoria: Value(m['categoria'] as String?),
          laboratorios: Value(_pgToJson(m['laboratorios'])),
          descripcion: Value(m['descripcion'] as String?),
          principiosActivos: Value(_pgToJson(m['principios_activos'])),
          composicionCompleta: Value(m['composicion_completa'] as String?),
          concentraciones: Value(_pgToJson(m['concentraciones'])),
          formasFarmaceuticas: Value(_pgToJson(m['formas_farmaceuticas'])),
          presentacion: Value(m['presentacion'] as String?),
          viasAdministracion: Value(_pgToJson(m['vias_administracion'])),
          indicacionesTexto: Value(m['indicaciones_texto'] as String?),
          indicacionesTags: Value(_pgToJson(m['indicaciones_tags'])),
          contraindicaciones: Value(m['contraindicaciones'] as String?),
          precaucionesAdvertencias: Value(
            m['precauciones_advertencias'] as String?,
          ),
          efectosAdversos: Value(m['efectos_adversos'] as String?),
          dosisAdultos: Value(m['dosis_adultos'] as String?),
          dosisAdultosMayores: Value(m['dosis_adultos_mayores'] as String?),
          dosisPediatrica: Value(m['dosis_pediatrica'] as String?),
          dosisLactantes: Value(m['dosis_lactantes'] as String?),
          fotoUrl: Value(m['foto_url_externa'] as String?),
          fechaRevision: Value(m['fecha_revision'] as String?),
          actualizadoEn: Value(m['actualizado_en'] as String?),
          esFavorito: const Value(false),
        ),
      );
    }
  }

  // Convierte formato PostgreSQL {val1,val2} o ya JSON a JSON string
  static String _pgToJson(dynamic value) {
    if (value == null) return '[]';
    if (value is List)
      return jsonEncode(value.map((e) => e.toString()).toList());
    final s = value.toString().trim();
    // Ya es JSON válido
    if (s.startsWith('[')) return s;
    // Formato PostgreSQL: {val1,"val con espacio",val2}
    if (s.startsWith('{') && s.endsWith('}')) {
      final inner = s.substring(1, s.length - 1);
      if (inner.isEmpty) return '[]';
      final result = <String>[];
      final regex = RegExp(r'"((?:[^"\\]|\\.)*)"|([^,]+)');
      for (final match in regex.allMatches(inner)) {
        final val = (match.group(1) ?? match.group(2) ?? '').trim();
        if (val.isNotEmpty) result.add(val);
      }
      return jsonEncode(result);
    }
    return '[]';
  }
}
