import 'dart:convert';
import 'dart:io';
import '../lib/core/search/dosis_filter.dart';

void main() {
  final rows =
      (jsonDecode(
                File(
                  'test/fixtures/medicamentos_filtros.json',
                ).readAsStringSync(),
              )
              as List)
          .cast<Map<String, dynamic>>();
  const groups = {
    'adulto': 'dosis_adultos',
    'adulto_mayor': 'dosis_adultos_mayores',
    'nino': 'dosis_pediatrica',
    'lactante': 'dosis_lactantes',
  };
  final report = StringBuffer(
    '# Revisión documental de las dosis\n\nFuente: CSV estandarizado proporcionado (100 medicamentos, 400 textos). No modifica datos ni establece indicaciones clínicas.\n\n',
  );
  report.writeln(
    'Se incluye cantidad/pauta escrita o referencia explícita a la misma dosis, pauta o esquema. Se excluyen ausencias, exclusiones sin pauta positiva y textos ambiguos. Una pauta parcial no implica que corresponda a todas las edades del grupo.\n',
  );
  report.writeln(
    '| Grupo | Con pauta | Exclusión explícita | Sin información | Requiere revisión |\n|---|---:|---:|---:|---:|',
  );
  final pending = <String>[];
  for (final g in groups.entries) {
    final counts = {for (final state in EstadoTextoDosis.values) state: 0};
    for (final row in rows) {
      final text = row[g.value] as String;
      final state = clasificarDosis(text, grupo: g.key);
      counts[state] = counts[state]! + 1;
      if (state == EstadoTextoDosis.requiereRevision)
        pending.add(
          '| ${row['codigo_interno']} | ${g.key} | ${text.replaceAll('|', '/')} |',
        );
    }
    report.writeln(
      '| ${g.key} | ${counts[EstadoTextoDosis.registrada]} | ${counts[EstadoTextoDosis.noCorresponde]} | ${counts[EstadoTextoDosis.sinInformacion]} | ${counts[EstadoTextoDosis.requiereRevision]} |',
    );
  }
  report.writeln(
    '\n## Textos excluidos del filtro que requieren revisión del contenido\n\nIncluye instrucciones generales sin pauta explícita, restricciones sin pauta positiva y referencias a lactancia materna en el campo de lactantes. No se ha corregido ni deducido su contenido.\n\n| Código | Grupo | Texto original |\n|---|---|---|',
  );
  for (final line in pending) report.writeln(line);
  File('REVISION_DOSIS.md').writeAsStringSync(report.toString());
  print('400 textos revisados; ${pending.length} requieren revisión.');
}
