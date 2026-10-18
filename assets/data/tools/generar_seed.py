#!/usr/bin/env python3
"""
Genera assets/data/seed_medicamentos.json desde el SQL de seed.
Requiere psycopg2: pip install psycopg2-binary
O usa la conexión directa de Supabase.

Alternativa manual: exporta la vista siguiente desde Supabase SQL Editor
y pégala como JSON en assets/data/seed_medicamentos.json
"""

# Query para ejecutar en Supabase SQL Editor → exportar como JSON:
QUERY = """
SELECT
  m.id,
  m.codigo_interno,
  m.nombre_comercial,
  m.nombre_generico,
  m.categoria,
  m.laboratorios,
  m.descripcion,
  m.principios_activos,
  m.composicion_completa,
  m.concentraciones,
  m.formas_farmaceuticas,
  m.presentacion,
  m.vias_administracion,
  m.indicaciones_texto,
  m.indicaciones_tags,
  m.contraindicaciones,
  m.precauciones_advertencias,
  m.efectos_adversos,
  m.dosis_adultos,
  m.dosis_adultos_mayores,
  m.dosis_pediatrica,
  m.dosis_lactantes,
  m.foto_path,
  m.fecha_revision,
  m.actualizado_en,
  COALESCE(mf.imagen_origen_url, '') AS foto_url_externa,
  (
    SELECT json_agg(json_build_object(
      'grupo', g.grupo,
      'estado', g.estado,
      'observacion', g.observacion
    ))
    FROM medicamento_grupos g
    WHERE g.medicamento_id = m.id
  ) AS grupos
FROM medicamentos m
LEFT JOIN medicamento_fuentes mf ON mf.medicamento_id = m.id
ORDER BY m.codigo_interno;
"""

print("Ejecuta esta query en Supabase SQL Editor y exporta como JSON.")
print("Guarda el resultado en assets/data/seed_medicamentos.json")
print()
print(QUERY)