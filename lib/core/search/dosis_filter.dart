// Filtra por presencia de información; no establece seguridad ni indicación.
bool tieneDosisInformada(String? dosis) {
  if (dosis == null) return false;
  final texto = dosis
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'[.!]+$'), '');
  return texto.isNotEmpty &&
      !const {
        'no corresponde',
        'no aplicable',
        'no aplica',
        'sin información',
        'sin informacion',
        'sin información registrada',
        'sin informacion registrada',
      }.contains(texto);
}
