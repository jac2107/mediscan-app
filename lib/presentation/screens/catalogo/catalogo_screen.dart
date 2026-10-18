import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/entities/filtros.dart';
import '../../providers/medicamentos_provider.dart';
import '../../providers/historial_provider.dart';
import '../../providers/voz_provider.dart';
import '../../providers/sync_provider.dart';
import '../../widgets/filtros/filtros_sheet.dart';
import '../../widgets/medicamento/medicamento_card.dart';
import '../../widgets/common/sync_indicator.dart';
import 'package:drift/drift.dart' hide Column;

class CatalogoScreen extends ConsumerStatefulWidget {
  const CatalogoScreen({super.key});

  @override
  ConsumerState<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends ConsumerState<CatalogoScreen> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();
  static const _uuid = Uuid();

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onQuery(String q) {
    ref.read(filtrosProvider.notifier).setQuery(q);
  }

  void _limpiar() {
    _ctrl.clear();
    ref.read(filtrosProvider.notifier).setQuery('');
  }

  Future<void> _abrirDetalle(MedicamentosTableData med) async {
    // Registrar historial
    await ref.read(appDatabaseProvider).insertHistorial(
          HistorialTableCompanion(
            id: Value(_uuid.v4()),
            medicamentoId: Value(med.id),
            nombreSnapshot: Value(med.nombreComercial),
            tipo: const Value('busqueda'),
            fecha: Value(DateTime.now()),
          ),
        );
    ref.invalidate(historialProvider);
    if (mounted) context.push('/medicamento/${med.id}');
  }

  Future<void> _iniciarVoz() async {
    await ref.read(vozProvider.notifier).iniciarEscucha(
      onResultado: (texto) {
        _ctrl.text = texto;
        ref.read(filtrosProvider.notifier).setQuery(texto);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtros = ref.watch(filtrosProvider);
    final resultadosAsync = ref.watch(resultadosBusquedaProvider);
    final vozState = ref.watch(vozProvider);
    final syncState = ref.watch(syncProvider);
    final theme = Theme.of(context);

    final escuchando = vozState.estado == EstadoVoz.escuchando;

    return Scaffold(
      appBar: AppBar(
        title: Text('MediScan',
            style: GoogleFonts.lora(fontSize: 20, color: AppTheme.ink)),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: SyncIndicator()),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(57),
          child: Column(
            children: [
              const Divider(height: 1),
              _BarraBusqueda(
                ctrl: _ctrl,
                focus: _focus,
                escuchando: escuchando,
                onChanged: _onQuery,
                onLimpiar: _limpiar,
                onVoz: escuchando
                    ? () => ref.read(vozProvider.notifier).detener()
                    : _iniciarVoz,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Estado de voz activo
          if (escuchando)
            Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.mic_rounded, size: 16, color: AppTheme.colorError),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      vozState.textoReconocido.isEmpty
                          ? 'Escuchando… di el nombre del medicamento'
                          : vozState.textoReconocido,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),

          // Barra de filtros activos + ordenamiento
          _BarraFiltros(
            filtros: filtros,
            onAbrirFiltros: () => _mostrarFiltros(context),
          ),

          const Divider(height: 1),

          // Lista de resultados
          Expanded(
            child: resultadosAsync.when(
              data: (resultados) {
                if (resultados.isEmpty) {
                  return _EstadoVacio(query: filtros.query);
                }
                return ListView.separated(
                  itemCount: resultados.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, indent: 24),
                  itemBuilder: (context, i) {
                    final med = resultados[i].medicamento;
                    return MedicamentoCard(
                      medicamento: med,
                      onTap: () => _abrirDetalle(med),
                      onFavoritoToggle: () async {
                        await ref.read(appDatabaseProvider).toggleFavorito(
                              med.id, !med.esFavorito);
                        ref.invalidate(todosMedicamentosProvider);
                        ref.invalidate(favoritosProvider);
                      },
                    );
                  },
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: AppTheme.verde),
                ),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Error: $e',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.colorError)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarFiltros(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.bgMarfil,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      builder: (_) => const FiltrosSheet(),
    );
  }
}

// ── Barra de búsqueda ─────────────────────────────────────────────────────────

class _BarraBusqueda extends StatelessWidget {
  final TextEditingController ctrl;
  final FocusNode focus;
  final bool escuchando;
  final ValueChanged<String> onChanged;
  final VoidCallback onLimpiar;
  final VoidCallback onVoz;

  const _BarraBusqueda({
    required this.ctrl,
    required this.focus,
    required this.escuchando,
    required this.onChanged,
    required this.onLimpiar,
    required this.onVoz,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 18, color: AppTheme.muted),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: ctrl,
              focusNode: focus,
              onChanged: onChanged,
              style: GoogleFonts.inter(fontSize: 15, color: AppTheme.ink),
              decoration: InputDecoration(
                hintText: 'Nombre, principio activo, categoría…',
                hintStyle:
                    GoogleFonts.inter(fontSize: 15, color: AppTheme.border),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                suffixIcon: ctrl.text.isNotEmpty
                    ? GestureDetector(
                        onTap: onLimpiar,
                        child: const Icon(Icons.close_rounded,
                            size: 16, color: AppTheme.muted),
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onVoz,
            child: Icon(
              escuchando ? Icons.mic_off_rounded : Icons.mic_none_rounded,
              size: 20,
              color: escuchando ? AppTheme.colorError : AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Barra de filtros activos ──────────────────────────────────────────────────

class _BarraFiltros extends StatelessWidget {
  final Filtros filtros;
  final VoidCallback onAbrirFiltros;

  const _BarraFiltros({required this.filtros, required this.onAbrirFiltros});

  @override
  Widget build(BuildContext context) {
    final total = filtros.totalFiltrosActivos;
    final labelOrden = _labelOrden(filtros.orden);

    return Container(
      color: AppTheme.bgMarfil,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          // Botón filtros
          GestureDetector(
            onTap: onAbrirFiltros,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.tune_rounded,
                  size: 16,
                  color: total > 0 ? AppTheme.verde : AppTheme.muted,
                ),
                const SizedBox(width: 4),
                Text(
                  total > 0 ? 'Filtros ($total)' : 'Filtrar',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: total > 0 ? AppTheme.verde : AppTheme.muted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          Container(width: 1, height: 14, color: AppTheme.border),
          const SizedBox(width: 12),

          // Orden actual
          GestureDetector(
            onTap: onAbrirFiltros,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sort_rounded, size: 16, color: AppTheme.muted),
                const SizedBox(width: 4),
                Text(
                  labelOrden,
                  style: GoogleFonts.inter(fontSize: 12, color: AppTheme.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _labelOrden(OrdenTipo orden) => switch (orden) {
        OrdenTipo.relevancia => 'Relevancia',
        OrdenTipo.nombreAZ => 'A → Z',
        OrdenTipo.nombreZA => 'Z → A',
        OrdenTipo.fechaReciente => 'Más reciente',
        OrdenTipo.categoria => 'Categoría',
      };
}

// ── Estado vacío ──────────────────────────────────────────────────────────────

class _EstadoVacio extends StatelessWidget {
  final String query;
  const _EstadoVacio({required this.query});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            query.isEmpty ? 'Sin medicamentos' : 'Sin coincidencias',
            style: GoogleFonts.lora(fontSize: 21, color: AppTheme.ink),
          ),
          const SizedBox(height: 6),
          Text(
            query.isEmpty
                ? 'El catálogo se cargará al conectar con internet.'
                : 'No encontramos resultados para "$query".\nRevisa la escritura o cambia los filtros.',
            style:
                theme.textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
          ),
        ],
      ),
    );
  }
}