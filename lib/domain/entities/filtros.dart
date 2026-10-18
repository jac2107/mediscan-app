enum OrdenTipo {
  relevancia,
  nombreAZ,
  nombreZA,
  fechaReciente,
  categoria,
}

class Filtros {
  final String query;
  final Set<String> categorias;
  final Set<String> principiosActivos;
  final Set<String> formasFarmaceuticas;
  final Set<String> viasAdministracion;
  final Set<String> laboratorios;
  final String? grupoFiltro; // adulto | adulto_mayor | nino | lactante
  final String? estadoGrupo; // aplicable | no_aplicable | no_evaluado
  final OrdenTipo orden;

  const Filtros({
    this.query = '',
    this.categorias = const {},
    this.principiosActivos = const {},
    this.formasFarmaceuticas = const {},
    this.viasAdministracion = const {},
    this.laboratorios = const {},
    this.grupoFiltro,
    this.estadoGrupo,
    this.orden = OrdenTipo.relevancia,
  });

  bool get tieneFiltroDuro =>
      categorias.isNotEmpty ||
      principiosActivos.isNotEmpty ||
      formasFarmaceuticas.isNotEmpty ||
      viasAdministracion.isNotEmpty ||
      laboratorios.isNotEmpty ||
      grupoFiltro != null;

  int get totalFiltrosActivos =>
      categorias.length +
      principiosActivos.length +
      formasFarmaceuticas.length +
      viasAdministracion.length +
      laboratorios.length +
      (grupoFiltro != null ? 1 : 0);

  Filtros copyWith({
    String? query,
    Set<String>? categorias,
    Set<String>? principiosActivos,
    Set<String>? formasFarmaceuticas,
    Set<String>? viasAdministracion,
    Set<String>? laboratorios,
    Object? grupoFiltro = _sentinel,
    Object? estadoGrupo = _sentinel,
    OrdenTipo? orden,
  }) =>
      Filtros(
        query: query ?? this.query,
        categorias: categorias ?? this.categorias,
        principiosActivos: principiosActivos ?? this.principiosActivos,
        formasFarmaceuticas: formasFarmaceuticas ?? this.formasFarmaceuticas,
        viasAdministracion: viasAdministracion ?? this.viasAdministracion,
        laboratorios: laboratorios ?? this.laboratorios,
        grupoFiltro: identical(grupoFiltro, _sentinel)
            ? this.grupoFiltro
            : grupoFiltro as String?,
        estadoGrupo: identical(estadoGrupo, _sentinel)
            ? this.estadoGrupo
            : estadoGrupo as String?,
        orden: orden ?? this.orden,
      );

  Filtros limpiarFiltros() => Filtros(query: query, orden: orden);
  Filtros limpiarTodo() => const Filtros();
}

const _sentinel = Object();