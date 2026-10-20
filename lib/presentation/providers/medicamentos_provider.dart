import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/search/fuzzy_search.dart';
import '../../data/local/database/app_database.dart';
import '../../domain/entities/filtros.dart';
import '../../core/search/dosis_filter.dart';

// ── Base de datos ─────────────────────────────────────────────────────────────

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ── Caché en memoria de todos los medicamentos ────────────────────────────────

final todosMedicamentosProvider = FutureProvider<List<MedicamentosTableData>>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  return db.getAllMedicamentos();
});

// ── Estado de filtros y búsqueda ──────────────────────────────────────────────

class FiltrosNotifier extends Notifier<Filtros> {
  @override
  Filtros build() => const Filtros();

  void setQuery(String q) => state = state.copyWith(query: q);

  void setOrden(OrdenTipo orden) => state = state.copyWith(orden: orden);

  void toggleCategoria(String cat) {
    final nuevo = Set<String>.from(state.categorias);
    nuevo.contains(cat) ? nuevo.remove(cat) : nuevo.add(cat);
    state = state.copyWith(categorias: nuevo);
  }

  void togglePrincipio(String p) {
    final nuevo = Set<String>.from(state.principiosActivos);
    nuevo.contains(p) ? nuevo.remove(p) : nuevo.add(p);
    state = state.copyWith(principiosActivos: nuevo);
  }

  void toggleForma(String f) {
    final nuevo = Set<String>.from(state.formasFarmaceuticas);
    nuevo.contains(f) ? nuevo.remove(f) : nuevo.add(f);
    state = state.copyWith(formasFarmaceuticas: nuevo);
  }

  void toggleVia(String v) {
    final nuevo = Set<String>.from(state.viasAdministracion);
    nuevo.contains(v) ? nuevo.remove(v) : nuevo.add(v);
    state = state.copyWith(viasAdministracion: nuevo);
  }

  void toggleLaboratorio(String l) {
    final nuevo = Set<String>.from(state.laboratorios);
    nuevo.contains(l) ? nuevo.remove(l) : nuevo.add(l);
    state = state.copyWith(laboratorios: nuevo);
  }

  void toggleGrupo(String grupo) {
    final nuevo = Set<String>.from(state.gruposPaciente);
    nuevo.contains(grupo) ? nuevo.remove(grupo) : nuevo.add(grupo);
    state = state.copyWith(gruposPaciente: nuevo);
  }

  void limpiarFiltros() => state = state.limpiarFiltros();
  void limpiarTodo() => state = state.limpiarTodo();
}

final filtrosProvider = NotifierProvider<FiltrosNotifier, Filtros>(
  FiltrosNotifier.new,
);

// ── Resultado de búsqueda con score ──────────────────────────────────────────

class MedicamentoConScore {
  final MedicamentosTableData medicamento;
  final double score;
  const MedicamentoConScore(this.medicamento, this.score);
}

final resultadosBusquedaProvider = FutureProvider<List<MedicamentoConScore>>((
  ref,
) async {
  final todos = await ref.watch(todosMedicamentosProvider.future);
  final filtros = ref.watch(filtrosProvider);
  // 1. Aplicar filtros duros
  List<MedicamentosTableData> filtrados = todos;

  if (filtros.categorias.isNotEmpty) {
    filtrados = filtrados
        .where(
          (m) =>
              m.categoria != null && filtros.categorias.contains(m.categoria),
        )
        .toList();
  }

  if (filtros.principiosActivos.isNotEmpty) {
    filtrados = filtrados.where((m) {
      final lista = AppDatabase.jsonToList(m.principiosActivos);
      return lista.any((p) => filtros.principiosActivos.contains(p));
    }).toList();
  }

  if (filtros.formasFarmaceuticas.isNotEmpty) {
    filtrados = filtrados.where((m) {
      final lista = AppDatabase.jsonToList(m.formasFarmaceuticas);
      return lista.any((f) => filtros.formasFarmaceuticas.contains(f));
    }).toList();
  }

  if (filtros.viasAdministracion.isNotEmpty) {
    filtrados = filtrados.where((m) {
      final lista = AppDatabase.jsonToList(m.viasAdministracion);
      return lista.any((v) => filtros.viasAdministracion.contains(v));
    }).toList();
  }

  if (filtros.laboratorios.isNotEmpty) {
    filtrados = filtrados.where((m) {
      final lista = AppDatabase.jsonToList(m.laboratorios);
      return lista.any((l) => filtros.laboratorios.contains(l));
    }).toList();
  }

  // OR entre grupos: solo comprueba si la columna de dosis contiene datos.
  if (filtros.gruposPaciente.isNotEmpty) {
    filtrados = filtrados
        .where(
          (m) => filtros.gruposPaciente.any(
            (grupo) => tieneDosisInformada(switch (grupo) {
              'adulto' => m.dosisAdultos,
              'adulto_mayor' => m.dosisAdultosMayores,
              'nino' => m.dosisPediatrica,
              'lactante' => m.dosisLactantes,
              _ => null,
            }),
          ),
        )
        .toList();
  }

  // 2. Score fuzzy
  final umbral = filtros.query.trim().isEmpty ? 0.0 : 10.0;
  final conScore = filtrados
      .map(
        (m) => MedicamentoConScore(m, FuzzySearch.score(m, filtros.query)),
      )
      .where((m) => m.score > umbral)
      .toList();

  // 3. Ordenar
  switch (filtros.orden) {
    case OrdenTipo.relevancia:
      if (filtros.query.trim().isNotEmpty) {
        conScore.sort((a, b) => b.score.compareTo(a.score));
      } else {
        conScore.sort(
          (a, b) => a.medicamento.nombreComercial.compareTo(
            b.medicamento.nombreComercial,
          ),
        );
      }
    case OrdenTipo.nombreAZ:
      conScore.sort(
        (a, b) => a.medicamento.nombreComercial.compareTo(
          b.medicamento.nombreComercial,
        ),
      );
    case OrdenTipo.nombreZA:
      conScore.sort(
        (a, b) => b.medicamento.nombreComercial.compareTo(
          a.medicamento.nombreComercial,
        ),
      );
    case OrdenTipo.fechaReciente:
      conScore.sort(
        (a, b) => (b.medicamento.fechaRevision ?? '').compareTo(
          a.medicamento.fechaRevision ?? '',
        ),
      );
    case OrdenTipo.categoria:
      conScore.sort(
        (a, b) => (a.medicamento.categoria ?? '').compareTo(
          b.medicamento.categoria ?? '',
        ),
      );
  }

  return conScore;
});

// ── Favoritos ─────────────────────────────────────────────────────────────────

final favoritosProvider = FutureProvider<List<MedicamentosTableData>>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  return db.getFavoritos();
});

// ── Historial ─────────────────────────────────────────────────────────────────

final historialProvider = FutureProvider<List<HistorialTableData>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return db.getHistorial();
});

// ── Medicamento individual ────────────────────────────────────────────────────

final medicamentoPorIdProvider =
    FutureProvider.family<MedicamentosTableData?, String>((ref, id) async {
  final db = ref.watch(appDatabaseProvider);
  return db.getMedicamentoById(id);
});

// ── Opciones para filtros ─────────────────────────────────────────────────────

final opcionesFiltrosProvider = FutureProvider<Map<String, List<String>>>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  final results = await Future.wait([
    db.getCategorias(),
    db.getPrincipiosActivos(),
    db.getFormasFarmaceuticas(),
    db.getViasAdministracion(),
    db.getLaboratorios(),
  ]);
  return {
    'categorias': results[0],
    'principios': results[1],
    'formas': results[2],
    'vias': results[3],
    'laboratorios': results[4],
  };
});
