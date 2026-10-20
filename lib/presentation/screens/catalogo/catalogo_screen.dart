import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../providers/medicamentos_provider.dart';
import '../../providers/voz_provider.dart';
import '../../providers/sync_provider.dart';
import '../../providers/connectivity_provider.dart';
import '../../widgets/filtros/filtros_sheet.dart';
import '../../widgets/medicamento/medicamento_card.dart';
import '../../widgets/common/brand_mark.dart';
import '../../widgets/common/editorial_notice.dart';
import '../../widgets/common/sync_indicator.dart';

class CatalogoScreen extends ConsumerStatefulWidget {
  const CatalogoScreen({super.key});
  @override
  ConsumerState<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends ConsumerState<CatalogoScreen> {
  late final TextEditingController _ctrl;
  final _focus = FocusNode();
  static const _uuid = Uuid();
  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: ref.read(filtrosProvider).query);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onQuery(String q) => ref.read(filtrosProvider.notifier).setQuery(q);
  void _limpiar() {
    _ctrl.clear();
    _onQuery('');
  }

  Future<void> _abrirDetalle(MedicamentosTableData med) async {
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
        if (!mounted) return;
        _ctrl.value = TextEditingValue(
          text: texto,
          selection: TextSelection.collapsed(offset: texto.length),
        );
        _onQuery(texto);
      },
    );
  }

  void _mostrarFiltros() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const FiltrosSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtros = ref.watch(filtrosProvider);
    final resultados = ref.watch(resultadosBusquedaProvider);
    final voz = ref.watch(vozProvider);
    final syncState = ref.watch(syncProvider);
    final sync = ref.watch(isConnectedProvider).valueOrNull == false
        ? EstadoSync.offline
        : syncState;
    final theme = Theme.of(context);
    final escuchando = voz.estado == EstadoVoz.escuchando;
    final iniciando = voz.estado == EstadoVoz.inicializando;
    final total = filtros.totalFiltrosActivos;
    final notifier = ref.read(filtrosProvider.notifier);
    final chips = <Widget>[];
    void agregar(Set<String> valores, void Function(String) quitar) {
      for (final valor in valores) {
        chips.add(
          InputChip(
            label: Text(valor),
            onDeleted: () => quitar(valor),
            deleteButtonTooltipMessage: 'Quitar filtro $valor',
          ),
        );
      }
    }

    agregar(filtros.categorias, notifier.toggleCategoria);
    agregar(filtros.principiosActivos, notifier.togglePrincipio);
    agregar(filtros.formasFarmaceuticas, notifier.toggleForma);
    agregar(filtros.viasAdministracion, notifier.toggleVia);
    agregar(filtros.laboratorios, notifier.toggleLaboratorio);
    const grupos = {
      'adulto': 'Adultos',
      'adulto_mayor': 'Adultos mayores',
      'nino': 'Niños',
      'lactante': 'Lactantes',
    };
    for (final grupo in filtros.gruposPaciente) {
      chips.add(
        InputChip(
          label: Text(grupos[grupo] ?? grupo),
          deleteButtonTooltipMessage: 'Quitar filtro ${grupos[grupo]}',
          onDeleted: () => notifier.toggleGrupo(grupo),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const BrandMark(),
        actions: [
          const SyncIndicator(),
          IconButton(
            tooltip: 'Actualizar catálogo',
            icon: const Icon(Icons.sync_outlined),
            onPressed: sync == EstadoSync.sincronizando
                ? null
                : () => ref.read(syncProvider.notifier).syncManual(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        key: const PageStorageKey('catalogo'),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      'Tu catálogo',
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Consulta medicamentos, incluso sin conexión.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Text('Buscar medicamento', style: theme.textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ctrl,
                          focusNode: _focus,
                          onChanged: _onQuery,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (_) => _focus.unfocus(),
                          style: theme.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Nombre o principio activo',
                            prefixIcon: const Icon(Icons.search_outlined),
                            suffixIcon: filtros.query.isEmpty
                                ? null
                                : IconButton(
                                    tooltip: 'Borrar búsqueda',
                                    onPressed: _limpiar,
                                    icon: const Icon(Icons.close_outlined),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedContainer(
                        duration: MediaQuery.of(context).disableAnimations
                            ? Duration.zero
                            : const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: escuchando ? AppTheme.verde : AppTheme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          tooltip: escuchando
                              ? 'Finalizar dictado'
                              : 'Dictar nombre del medicamento',
                          constraints: const BoxConstraints(
                            minWidth: 52,
                            minHeight: 56,
                          ),
                          onPressed: iniciando
                              ? null
                              : escuchando
                                  ? () =>
                                      ref.read(vozProvider.notifier).detener()
                                  : _iniciarVoz,
                          icon: iniciando
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  escuchando
                                      ? Icons.stop_circle_outlined
                                      : Icons.mic_none_outlined,
                                  color: escuchando
                                      ? AppTheme.bgMarfil
                                      : AppTheme.verde,
                                ),
                        ),
                      ),
                    ],
                  ),
                  if (escuchando || iniciando || voz.mensajeError != null) ...[
                    const SizedBox(height: 12),
                    EditorialNotice(
                      icon: escuchando
                          ? Icons.mic_none_outlined
                          : Icons.info_outline,
                      color: voz.estado == EstadoVoz.error
                          ? AppTheme.colorError
                          : AppTheme.verde,
                      busy: iniciando,
                      message: iniciando
                          ? 'Preparando el micrófono…'
                          : escuchando
                              ? 'Escuchando… Di el nombre del medicamento.${voz.textoReconocido.isEmpty ? '' : '\n${voz.textoReconocido}'}'
                              : voz.mensajeError!,
                      action: escuchando
                          ? TextButton(
                              onPressed: () =>
                                  ref.read(vozProvider.notifier).cancelar(),
                              child: const Text('Cancelar dictado'),
                            )
                          : null,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _mostrarFiltros,
                        icon: const Icon(Icons.tune_outlined, size: 20),
                        label: Text(
                          total == 0 ? 'Filtros' : 'Filtros ($total)',
                        ),
                      ),
                      if (total > 0)
                        TextButton(
                          onPressed: notifier.limpiarFiltros,
                          child: const Text('Limpiar filtros'),
                        ),
                    ],
                  ),
                  if (chips.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Wrap(spacing: 8, runSpacing: 4, children: chips),
                    ),
                  if (sync == EstadoSync.offline ||
                      sync == EstadoSync.error ||
                      sync == EstadoSync.sincronizando) ...[
                    const SizedBox(height: 16),
                    EditorialNotice(
                      icon: sync == EstadoSync.offline
                          ? Icons.wifi_off_outlined
                          : Icons.info_outline,
                      color: sync == EstadoSync.error
                          ? AppTheme.colorError
                          : AppTheme.muted,
                      busy: sync == EstadoSync.sincronizando,
                      message: switch (sync) {
                        EstadoSync.offline =>
                          'Sin conexión. Tu catálogo sigue disponible.',
                        EstadoSync.error =>
                          'No pudimos actualizar. Puedes seguir consultando el catálogo disponible.',
                        _ =>
                          'Actualizando catálogo… Puedes seguir consultando.',
                      },
                      action: sync == EstadoSync.error
                          ? TextButton(
                              onPressed: () =>
                                  ref.read(syncProvider.notifier).syncManual(),
                              child: const Text('Reintentar'),
                            )
                          : null,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      resultados.when(
                        data: (items) =>
                            '${items.length} ${items.length == 1 ? 'resultado' : 'resultados'}',
                        loading: () => 'Buscando…',
                        error: (_, __) => 'Consulta no disponible',
                      ),
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          resultados.when(
            data: (items) => items.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.search_off_outlined,
                            color: AppTheme.muted,
                            size: 32,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No encontramos coincidencias',
                            style: theme.textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Revisa lo escrito o cambia los filtros.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      final med = items[i].medicamento;
                      return MedicamentoCard(
                        medicamento: med,
                        onTap: () => _abrirDetalle(med),
                        onFavoritoToggle: () async {
                          await ref
                              .read(appDatabaseProvider)
                              .toggleFavorito(med.id, !med.esFavorito);
                          ref.invalidate(todosMedicamentosProvider);
                          ref.invalidate(favoritosProvider);
                        },
                      );
                    }, childCount: items.length),
                  ),
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
            error: (_, __) => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: EditorialNotice(
                  icon: Icons.error_outline,
                  message:
                      'No pudimos consultar el catálogo. Vuelve a intentarlo.',
                  color: AppTheme.colorError,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
