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
}