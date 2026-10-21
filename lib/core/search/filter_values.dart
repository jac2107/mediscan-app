import 'dart:convert';
import 'categorias_legadas.dart';

// Comparison keys only. Displayed clinical information remains unchanged.
String normalizarFiltro(String value) => value
    .toLowerCase()
    .replaceAll(RegExp('[áàäâã]'), 'a')
    .replaceAll(RegExp('[éèëê]'), 'e')
    .replaceAll(RegExp('[íìïî]'), 'i')
    .replaceAll(RegExp('[óòöôõ]'), 'o')
    .replaceAll(RegExp('[úùüû]'), 'u')
    .replaceAll('ñ', 'n')
    .replaceAll(RegExp(r'[\u0300-\u036f]'), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

enum CampoFiltro { categoria, principio, forma, via, laboratorio }

List<String> leerValoresFiltro(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.whereType<String>().toList();
  if (value is! String || value.trim().isEmpty) return [];
  try {
    final decoded = jsonDecode(value);
    if (decoded is List) return decoded.whereType<String>().toList();
    if (decoded is String && decoded != value) {
      return leerValoresFiltro(decoded);
    }
    return [];
  } on FormatException {
    return value.trimLeft().startsWith('[') ? [] : [value];
  }
}

const _principiosLegados = <String, List<String>>{
  'dexametasona / dexametasona fosfato': [
    'Dexametasona',
    'Dexametasona fosfato',
  ],
  'diclofenaco sodico / potasico': [
    'Diclofenaco sódico',
    'Diclofenaco potásico',
  ],
  'clindamicina clorhidrato / fosfato': [
    'Clindamicina clorhidrato',
    'Clindamicina fosfato',
  ],
  'esomeprazol magnesico / sodico': [
    'Esomeprazol magnésico',
    'Esomeprazol sódico',
  ],
  'carbonato de calcio (o citrato de calcio)': [
    'Carbonato de calcio',
    'Citrato de calcio',
  ],
};
List<String> _separarAlternativas(String text) {
  final out = <String>[];
  var depth = 0, start = 0;
  for (var i = 0; i < text.length; i++) {
    if (text[i] == '(') depth++;
    if (text[i] == ')') depth--;
    if (depth == 0 && text.substring(i).startsWith(' / ')) {
      out.add(text.substring(start, i));
      start = i + 3;
      i += 2;
    }
  }
  out.add(text.substring(start));
  return out;
}

List<String> elementosFiltro(
  dynamic value,
  CampoFiltro campo,
) =>
    leerValoresFiltro(value)
        .expand((raw) {
          final text = raw.replaceAll(RegExp(r'\s+'), ' ').trim(),
              key = normalizarFiltro(raw);
          if (campo == CampoFiltro.categoria) {
            return categoriasLegadas[key] ?? [text];
          }
          if (campo == CampoFiltro.principio) {
            return _principiosLegados[key] ?? [text];
          }
          if (campo == CampoFiltro.laboratorio)
            return _separarAlternativas(text);
          if (campo == CampoFiltro.via) {
            if (key == 'topica/vaginal') return ['Tópica', 'Vaginal'];
            return _separarAlternativas(text);
          }
          if (campo == CampoFiltro.forma) {
            if (key == 'gel/jalea topica')
              return ['Gel tópico', 'Jalea tópica'];
            if (key == 'tabletas; suspension') return ['Tableta', 'Suspensión'];
            if (key == 'jarabe/solucion oral')
              return ['Jarabe', 'Solución oral'];
            return _separarAlternativas(text);
          }
          return [text];
        })
        .where((s) => s.trim().isNotEmpty)
        .toList();
String claveFiltro(String value, CampoFiltro campo) {
  var key = normalizarFiltro(value);
  if (campo == CampoFiltro.principio) {
    key = key.replaceAll(RegExp(r'\s*\(b(?:1|6|12)\)$'), '').trim();
  }
  if (campo == CampoFiltro.forma) {
    const aliases = {
      'solucion inyectable parenteral': 'solucion inyectable',
      'solucion inyectable transparente y translucida': 'solucion inyectable',
      'solucion inyectable (im/iv)': 'solucion inyectable',
      'solucion inyectable im/iv': 'solucion inyectable',
      'solucion inyectable im': 'solucion inyectable',
      'solucion inyectable iv': 'solucion inyectable',
      'solucion para infusion iv': 'solucion para infusion',
      'solucion concentrada para infusion iv':
          'solucion concentrada para infusion',
      'polvo para solucion inyectable iv': 'polvo para solucion inyectable',
      'polvo para inyectable iv': 'polvo para solucion inyectable',
      'polvo para solucion inyectable (im/iv)':
          'polvo para solucion inyectable',
      'polvo para suspension inyectable im': 'polvo para suspension inyectable',
      'suspension inyectable (aspecto turbio/lechoso tras homogeneizar)':
          'suspension inyectable',
      'solucion para irrigacion topica/nasal': 'solucion para irrigacion',
      'aerosol/spray topico': 'aerosol topico',
      'crema dermatologica': 'crema topica',
      'crema': 'crema topica',
      'unguento': 'unguento topico',
      'solucion oral en gotas': 'gotas orales',
      'aerosol para inhalacion oral': 'aerosol para inhalacion',
    };
    return aliases[key] ?? key;
  }
  if (campo == CampoFiltro.via) {
    for (final base in [
      'oral',
      'intravenosa',
      'intramuscular',
      'subcutanea',
      'rectal',
      'sublingual',
      'nasal',
    ]) {
      if (key == base ||
          key.startsWith('$base (') ||
          (base == 'intravenosa' &&
              (key.startsWith('intravenosa lenta') ||
                  key.startsWith('intravenosa directa lenta'))) ||
          (base == 'intramuscular' &&
              key.startsWith('intramuscular profunda'))) {
        return base;
      }
    }
    if (key == 'infiltracion subcutanea') return 'subcutanea';
    if (key == 'inhalatoria oral') return 'inhalatoria';
    if (key == 'topica cutanea') return 'topica';
  }
  return key;
}

bool coincideFiltro(dynamic value, Set<String> selected, CampoFiltro campo) {
  if (selected.isEmpty) return true;
  final keys = selected.map((v) => claveFiltro(v, campo)).toSet();
  return elementosFiltro(
    value,
    campo,
  ).any((v) => keys.contains(claveFiltro(v, campo)));
}

List<String> opcionesUnicas(Iterable<dynamic> values, CampoFiltro campo) {
  final labels = <String, String>{};
  for (final value in values) {
    for (final label in elementosFiltro(value, campo)) {
      final key = claveFiltro(label, campo);
      if (key.isNotEmpty &&
          (!labels.containsKey(key) || normalizarFiltro(label) == key)) {
        labels[key] = label;
      }
    }
  }
  final sorted = labels.values.toList();
  sorted.sort((a, b) => normalizarFiltro(a).compareTo(normalizarFiltro(b)));
  return sorted;
}

// Texto visible compartido por tarjetas, detalle, búsqueda y ordenación.
String textoCategorias(dynamic value) =>
    opcionesUnicas([value], CampoFiltro.categoria).join(' · ');
