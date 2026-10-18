import '../../data/local/database/app_database.dart';

class FuzzySearch {
  // ── Normalización ───────────────────────────────────────────────────────────

  static String normalize(String text) => text
      .toLowerCase()
      .replaceAll(RegExp(r'[áàäâã]'), 'a')
      .replaceAll(RegExp(r'[éèëê]'), 'e')
      .replaceAll(RegExp(r'[íìïî]'), 'i')
      .replaceAll(RegExp(r'[óòöôõ]'), 'o')
      .replaceAll(RegExp(r'[úùüû]'), 'u')
      .replaceAll('ñ', 'n')
      .replaceAll(RegExp(r'[^\w\s]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  // ── Levenshtein ─────────────────────────────────────────────────────────────

  static int levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final m = a.length, n = b.length;
    var row = List<int>.generate(n + 1, (i) => i);

    for (int i = 1; i <= m; i++) {
      int prev = row[0];
      row[0] = i;
      for (int j = 1; j <= n; j++) {
        final temp = row[j];
        row[j] = a[i - 1] == b[j - 1]
            ? prev
            : 1 + [prev, row[j], row[j - 1]].reduce((a, b) => a < b ? a : b);
        prev = temp;
      }
    }
    return row[n];
  }

  // ── Score de un campo vs query ──────────────────────────────────────────────

  static double _scoreField(String? field, String normQuery, List<String> queryWords) {
    if (field == null || field.isEmpty || normQuery.isEmpty) return 0;
    final nf = normalize(field);

    // Coincidencia exacta / prefijo / contiene
    if (nf == normQuery) return 100;
    if (nf.startsWith(normQuery)) return 90;
    if (nf.contains(normQuery)) return 70;

    // Coincidencia por palabras
    final fieldWords = nf.split(' ').where((w) => w.length > 1).toList();
    double best = 0;

    for (final qw in queryWords) {
      if (qw.length < 2) continue;
      for (final fw in fieldWords) {
        double s = 0;
        if (fw == qw) {
          s = 80;
        } else if (fw.startsWith(qw)) {
          s = 65;
        } else if (fw.contains(qw)) {
          s = 50;
        } else if (qw.length >= 4) {
          final dist = levenshtein(qw, fw);
          if (dist == 1) s = 45;
          else if (dist == 2 && qw.length >= 6) s = 30;
        }
        if (s > best) best = s;
      }
    }
    return best;
  }

  // ── Score total de un medicamento ───────────────────────────────────────────

  static double score(MedicamentosTableData med, String query) {
    if (query.trim().isEmpty) return 100;
    final q = normalize(query);
    final words = q.split(' ').where((w) => w.length > 1).toList();

    double total = 0;

    // nombre_comercial (peso 3.0) — más importante
    total += _scoreField(med.nombreComercial, q, words) * 3.0;

    // nombre_generico (peso 3.0)
    total += _scoreField(med.nombreGenerico, q, words) * 3.0;

    // principios_activos (peso 2.5 por elemento)
    for (final p in AppDatabase.jsonToList(med.principiosActivos)) {
      final s = _scoreField(p, q, words);
      if (s > 0) { total += s * 2.5; break; } // primer match basta
    }

    // categoria (peso 1.5)
    total += _scoreField(med.categoria, q, words) * 1.5;

    // indicaciones_tags (peso 1.0)
    for (final t in AppDatabase.jsonToList(med.indicacionesTags)) {
      final s = _scoreField(t, q, words);
      if (s > 40) { total += s * 1.0; break; }
    }

    // laboratorios (peso 0.8)
    for (final l in AppDatabase.jsonToList(med.laboratorios)) {
      final s = _scoreField(l, q, words);
      if (s > 50) { total += s * 0.8; break; }
    }

    // formas farmacéuticas (peso 0.5)
    for (final f in AppDatabase.jsonToList(med.formasFarmaceuticas)) {
      final s = _scoreField(f, q, words);
      if (s > 60) { total += s * 0.5; break; }
    }

    return total;
  }
}