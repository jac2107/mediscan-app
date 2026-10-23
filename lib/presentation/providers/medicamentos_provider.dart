import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/search/fuzzy_search.dart';
import '../../data/local/database/app_database.dart';
import '../../domain/entities/filtros.dart';
import '../../core/search/dosis_filter.dart';
import '../../core/search/filter_values.dart';

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
    final key = claveFiltro(cat, CampoFiltro.categoria);
    final existing = nuevo
        .where((v) => claveFiltro(v, CampoFiltro.categoria) == key)
        .toList();
    if (existing.isEmpty) {
      nuevo.add(cat);
    } else {
      nuevo.removeAll(existing);
    }
    state = state.copyWith(categorias: nuevo);
  }

  void togglePrincipio(String p) {
    final nuevo = Set<String>.from(state.principiosActivos);
    final key = claveFiltro(p, CampoFiltro.principio);
    final existing = nuevo
        .where((v) => claveFiltro(v, CampoFiltro.principio) == key)
        .toList();
    if (existing.isEmpty) {
      nuevo.add(p);
    } else {
      nuevo.removeAll(existing);
    }
    state = state.copyWith(principiosActivos: nuevo);
  }

  void toggleForma(String f) {
    final nuevo = Set<String>.from(state.formasFarmaceuticas);
    final key = claveFiltro(f, CampoFiltro.forma);
    final existing = nuevo
        .where((v) => claveFiltro(v, CampoFiltro.forma) == key)
        .toList();
    if (existing.isEmpty) {
      nuevo.add(f);
    } else {
      nuevo.removeAll(existing);
    }
    state = state.copyWith(formasFarmaceuticas: nuevo);
  }

  void toggleVia(String v) {
    final nuevo = Set<String>.from(state.viasAdministracion);
    final key = claveFiltro(v, CampoFiltro.via);
    final existing = nuevo
        .where((v) => claveFiltro(v, CampoFiltro.via) == key)
        .toList();
    if (existing.isEmpty) {
      nuevo.add(v);
    } else {
      nuevo.removeAll(existing);
    }
    state = state.copyWith(viasAdministracion: nuevo);
  }

  void toggleLaboratorio(String l) {
    final nuevo = Set<String>.from(state.laboratorios);
    final key = claveFiltro(l, CampoFiltro.laboratorio);
    final existing = nuevo
        .where((v) => claveFiltro(v, CampoFiltro.laboratorio) == key)
        .toList();
    if (existing.isEmpty) {
      nuevo.add(l);
    } else {
      nuevo.removeAll(existing);
    }
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

  filtrados = filtrados
      .where(
        (m) =>
            coincideFiltro(
              m.categoria,
              filtros.categorias,
              CampoFiltro.categoria,
            ) &&
            coincideFiltro(
              m.principiosActivos,
              filtros.principiosActivos,
              CampoFiltro.principio,
            ) &&
            coincideFiltro(
              m.formasFarmaceuticas,
              filtros.formasFarmaceuticas,
              CampoFiltro.forma,
            ) &&
            coincideFiltro(
              m.viasAdministracion,
              filtros.viasAdministracion,
              CampoFiltro.via,
            ) &&
            coincideFiltro(
              m.laboratorios,
              filtros.laboratorios,
              CampoFiltro.laboratorio,
            ),
      )
      .toList();

  // OR entre grupos con dosis o pauta documentada.
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
            }, grupo: grupo),
          ),
        )
        .toList();
  }

  // 2. Score fuzzy
  final umbral = filtros.query.trim().isEmpty ? 0.0 : 10.0;
  final conScore = filtrados
      .map((m) => MedicamentoConScore(m, FuzzySearch.score(m, filtros.query)))
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
        (a, b) => normalizarFiltro(
          textoCategorias(a.medicamento.categoria),
        ).compareTo(normalizarFiltro(textoCategorias(b.medicamento.categoria))),
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
  final rows = await ref.watch(todosMedicamentosProvider.future);
  return {
    'categorias': opcionesUnicas(
      rows.map((m) => m.categoria),
      CampoFiltro.categoria,
    ),
    'principios': opcionesUnicas(
      rows.map((m) => m.principiosActivos),
      CampoFiltro.principio,
    ),
    'formas': opcionesUnicas(
      rows.map((m) => m.formasFarmaceuticas),
      CampoFiltro.forma,
    ),
    'vias': opcionesUnicas(
      rows.map((m) => m.viasAdministracion),
      CampoFiltro.via,
    ),
    'laboratorios': opcionesUnicas(
      rows.map((m) => m.laboratorios),
      CampoFiltro.laboratorio,
    ),
  };
});
