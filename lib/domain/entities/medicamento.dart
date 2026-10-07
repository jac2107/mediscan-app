class Medicamento {
  final String id;
  final String codigoBarras;
  final String nombre;
  final String? descripcion;
  final String? fotoUrl;
  final String? dosisAdulto;
  final String? dosisMayor;
  final String? dosisNino;
  final List<String> alergias;
  final List<String> contraindicaciones;
  final List<String> enfermedadesIncompatibles;
  final DateTime actualizadoEn;
  final bool eliminado;

  const Medicamento({
    required this.id,
    required this.codigoBarras,
    required this.nombre,
    this.descripcion,
    this.fotoUrl,
    this.dosisAdulto,
    this.dosisMayor,
    this.dosisNino,
    this.alergias = const [],
    this.contraindicaciones = const [],
    this.enfermedadesIncompatibles = const [],
    required this.actualizadoEn,
    this.eliminado = false,
  });

  Medicamento copyWith({
    String? id,
    String? codigoBarras,
    String? nombre,
    String? descripcion,
    String? fotoUrl,
    String? dosisAdulto,
    String? dosisMayor,
    String? dosisNino,
    List<String>? alergias,
    List<String>? contraindicaciones,
    List<String>? enfermedadesIncompatibles,
    DateTime? actualizadoEn,
    bool? eliminado,
  }) {
    return Medicamento(
      id: id ?? this.id,
      codigoBarras: codigoBarras ?? this.codigoBarras,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      dosisAdulto: dosisAdulto ?? this.dosisAdulto,
      dosisMayor: dosisMayor ?? this.dosisMayor,
      dosisNino: dosisNino ?? this.dosisNino,
      alergias: alergias ?? this.alergias,
      contraindicaciones: contraindicaciones ?? this.contraindicaciones,
      enfermedadesIncompatibles:
          enfermedadesIncompatibles ?? this.enfermedadesIncompatibles,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      eliminado: eliminado ?? this.eliminado,
    );
  }
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'codigo_barras': codigoBarras,
    'nombre': nombre,
    'descripcion': descripcion,
    'foto_url': fotoUrl,
    'dosis_adulto': dosisAdulto,
    'dosis_mayor': dosisMayor,
    'dosis_nino': dosisNino,
    'alergias': alergias,
    'contraindicaciones': contraindicaciones,
    'enfermedades_incompatibles': enfermedadesIncompatibles,
    'actualizado_en': actualizadoEn.toIso8601String(),
    'eliminado': eliminado,
  };
}

factory Medicamento.fromMap(Map<String, dynamic> map) {
  return Medicamento(
    id: map['id'] as String,
    codigoBarras: map['codigo_barras'] as String,
    nombre: map['nombre'] as String,
    descripcion: map['descripcion'] as String?,
    fotoUrl: map['foto_url'] as String?,
    dosisAdulto: map['dosis_adulto'] as String?,
    dosisMayor: map['dosis_mayor'] as String?,
    dosisNino: map['dosis_nino'] as String?,
    alergias: List<String>.from(map['alergias'] ?? []),
    contraindicaciones: List<String>.from(map['contraindicaciones'] ?? []),
    enfermedadesIncompatibles:
        List<String>.from(map['enfermedades_incompatibles'] ?? []),
    actualizadoEn: DateTime.parse(map['actualizado_en'] as String),
    eliminado: map['eliminado'] as bool? ?? false,
  );
}
}
