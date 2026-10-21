import 'filter_values.dart';

/// Classification of documented text; never clinical eligibility.
enum EstadoTextoDosis {
  registrada,
  noCorresponde,
  sinInformacion,
  requiereRevision,
}

EstadoTextoDosis clasificarDosis(String? dosis, {String? grupo}) {
  final text = normalizarFiltro(dosis ?? '');
  if (text.isEmpty ||
      RegExp(
        r'^(sin informacion|sin datos|no disponible|no se (ha )?establecido|dosis no establecida)',
      ).hasMatch(text)) {
    return EstadoTextoDosis.sinInformacion;
  }
  if (grupo == 'lactante' &&
      RegExp(
        r'mujeres lactantes|posparto|postparto|leche materna|produccion lactea|edad fertil|menarquicas',
      ).hasMatch(text)) {
    return EstadoTextoDosis.requiereRevision;
  }
  final exclusion = RegExp(
    r'\b(contraindicad[oa]s?|no recomendad[oa]s?|no indicad[oa]s?|no aplicable|no aplica|no corresponde)\b',
  ).hasMatch(text);
  final quantity = RegExp(
    r'\d+(?:[.,]\d+)?\s*(?:mg|mcg|µg|ug|g|ml|ui|mui|tabletas?|ampollas?|gotas?|puffs?|disparos?)\b',
  ).hasMatch(text);
  final regimen = RegExp(
    r'(aplicar|aplicacion|champu|crema|topico).*\d+.*(?:veces|horas|minutos|dias)',
  ).hasMatch(text);
  final reference = RegExp(
    r'\b(mism[oa]s? (?:dosis|esquemas?|pautas?|posologia)|no requiere ajuste de dosis|sin ajuste|dosis de adulto)\b',
  ).hasMatch(text);
  if (quantity || regimen || reference) {
    if (!exclusion) return EstadoTextoDosis.registrada;
    final positive = text
        .split(RegExp(r'\.\s+|;\s*'))
        .any(
          (clause) =>
              !RegExp(
                r'contraindicad|no recomendad|no indicad',
              ).hasMatch(clause) &&
              (RegExp(
                    r'\d+(?:[.,]\d+)?\s*(?:mg|mcg|g|ml|ui)\b',
                  ).hasMatch(clause) ||
                  RegExp(
                    r'dosis de adulto|misma dosis|mismo esquema',
                  ).hasMatch(clause)),
        );
    return positive
        ? EstadoTextoDosis.registrada
        : EstadoTextoDosis.requiereRevision;
  }
  if (exclusion) {
    if (RegExp(
      r'en menores|en <|\bsi\b|salvo|en ampollas|este formato|de rutina',
    ).hasMatch(text)) {
      return EstadoTextoDosis.requiereRevision;
    }
    return EstadoTextoDosis.noCorresponde;
  }
  return EstadoTextoDosis.requiereRevision;
}

bool tieneDosisInformada(String? dosis, {String? grupo}) =>
    clasificarDosis(dosis, grupo: grupo) == EstadoTextoDosis.registrada;
