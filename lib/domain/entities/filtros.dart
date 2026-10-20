enum OrdenTipo { relevancia, nombreAZ, nombreZA, fechaReciente, categoria }

class Filtros {
  final String query;
  final Set<String> categorias;
  final Set<String> principiosActivos;
  final Set<String> formasFarmaceuticas;
  final Set<String> viasAdministracion;
  final Set<String> laboratorios;
  final Set<String> gruposPaciente; // Dosis informada, no evaluación clínica.
  final OrdenTipo orden;

  const Filtros({
    this.query = '',
    this.categorias = const {},
    this.principiosActivos = const {},
    this.formasFarmaceuticas = const {},
    this.viasAdministracion = const {},
    this.laboratorios = const {},
    this.gruposPaciente = const {},
    this.orden = OrdenTipo.relevancia,
  });

  bool get tieneFiltroDuro =>
      categorias.isNotEmpty ||
      principiosActivos.isNotEmpty ||
      formasFarmaceuticas.isNotEmpty ||
      viasAdministracion.isNotEmpty ||
      laboratorios.isNotEmpty ||
      gruposPaciente.isNotEmpty;

  int get totalFiltrosActivos =>
      categorias.length +
      principiosActivos.length +
      formasFarmaceuticas.length +
      viasAdministracion.length +
      laboratorios.length +
      gruposPaciente.length;

  Filtros copyWith({
    String? query,
    Set<String>? categorias,
    Set<String>? principiosActivos,
    Set<String>? formasFarmaceuticas,
    Set<String>? viasAdministracion,
    Set<String>? laboratorios,
    Set<String>? gruposPaciente,
    OrdenTipo? orden,
  }) =>
      Filtros(
        query: query ?? this.query,
        categorias: categorias ?? this.categorias,
        principiosActivos: principiosActivos ?? this.principiosActivos,
        formasFarmaceuticas: formasFarmaceuticas ?? this.formasFarmaceuticas,
        viasAdministracion: viasAdministracion ?? this.viasAdministracion,
        laboratorios: laboratorios ?? this.laboratorios,
        gruposPaciente: gruposPaciente ?? this.gruposPaciente,
        orden: orden ?? this.orden,
      );

  Filtros limpiarFiltros() => Filtros(query: query, orden: orden);
  Filtros limpiarTodo() => const Filtros();
}
