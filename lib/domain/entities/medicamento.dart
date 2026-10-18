class Medicamento {
  final String id;
  final String codigoInterno;
  final String nombreComercial;
  final String? nombreGenerico;
  final String? categoria;
  final List<String> laboratorios;
  final String? descripcion;
  final List<String> principiosActivos;
  final String? composicionCompleta;
  final List<String> concentraciones;
  final List<String> formasFarmaceuticas;
  final String? presentacion;
  final List<String> viasAdministracion;
  final String? indicacionesTexto;
  final List<String> indicacionesTags;
  final String? contraindicaciones;
  final String? precaucionesAdvertencias;
  final String? efectosAdversos;
  final String? dosisAdultos;
  final String? dosisAdultosMayores;
  final String? dosisPediatrica;
  final String? dosisLactantes;
  final String? fotoUrl;
  final String? fechaRevision;
  final String? actualizadoEn;
  final bool esFavorito;

  const Medicamento({
    required this.id,
    required this.codigoInterno,
    required this.nombreComercial,
    this.nombreGenerico,
    this.categoria,
    this.laboratorios = const [],
    this.descripcion,
    this.principiosActivos = const [],
    this.composicionCompleta,
    this.concentraciones = const [],
    this.formasFarmaceuticas = const [],
    this.presentacion,
    this.viasAdministracion = const [],
    this.indicacionesTexto,
    this.indicacionesTags = const [],
    this.contraindicaciones,
    this.precaucionesAdvertencias,
    this.efectosAdversos,
    this.dosisAdultos,
    this.dosisAdultosMayores,
    this.dosisPediatrica,
    this.dosisLactantes,
    this.fotoUrl,
    this.fechaRevision,
    this.actualizadoEn,
    this.esFavorito = false,
  });

  Medicamento copyWith({
    String? id,
    String? codigoInterno,
    String? nombreComercial,
    String? nombreGenerico,
    String? categoria,
    List<String>? laboratorios,
    String? descripcion,
    List<String>? principiosActivos,
    String? composicionCompleta,
    List<String>? concentraciones,
    List<String>? formasFarmaceuticas,
    String? presentacion,
    List<String>? viasAdministracion,
    String? indicacionesTexto,
    List<String>? indicacionesTags,
    String? contraindicaciones,
    String? precaucionesAdvertencias,
    String? efectosAdversos,
    String? dosisAdultos,
    String? dosisAdultosMayores,
    String? dosisPediatrica,
    String? dosisLactantes,
    String? fotoUrl,
    String? fechaRevision,
    String? actualizadoEn,
    bool? esFavorito,
  }) {
    return Medicamento(
      id: id ?? this.id,
      codigoInterno: codigoInterno ?? this.codigoInterno,
      nombreComercial: nombreComercial ?? this.nombreComercial,
      nombreGenerico: nombreGenerico ?? this.nombreGenerico,
      categoria: categoria ?? this.categoria,
      laboratorios: laboratorios ?? this.laboratorios,
      descripcion: descripcion ?? this.descripcion,
      principiosActivos: principiosActivos ?? this.principiosActivos,
      composicionCompleta: composicionCompleta ?? this.composicionCompleta,
      concentraciones: concentraciones ?? this.concentraciones,
      formasFarmaceuticas: formasFarmaceuticas ?? this.formasFarmaceuticas,
      presentacion: presentacion ?? this.presentacion,
      viasAdministracion: viasAdministracion ?? this.viasAdministracion,
      indicacionesTexto: indicacionesTexto ?? this.indicacionesTexto,
      indicacionesTags: indicacionesTags ?? this.indicacionesTags,
      contraindicaciones: contraindicaciones ?? this.contraindicaciones,
      precaucionesAdvertencias:
          precaucionesAdvertencias ?? this.precaucionesAdvertencias,
      efectosAdversos: efectosAdversos ?? this.efectosAdversos,
      dosisAdultos: dosisAdultos ?? this.dosisAdultos,
      dosisAdultosMayores: dosisAdultosMayores ?? this.dosisAdultosMayores,
      dosisPediatrica: dosisPediatrica ?? this.dosisPediatrica,
      dosisLactantes: dosisLactantes ?? this.dosisLactantes,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      fechaRevision: fechaRevision ?? this.fechaRevision,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      esFavorito: esFavorito ?? this.esFavorito,
    );
  }
}