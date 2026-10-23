import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/search/filter_values.dart';
import '../../../domain/entities/filtros.dart';
import '../../providers/medicamentos_provider.dart';

class FiltrosSheet extends ConsumerWidget {
  const FiltrosSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtros = ref.watch(filtrosProvider);
    final opcionesAsync = ref.watch(opcionesFiltrosProvider);
    final notifier = ref.read(filtrosProvider.notifier);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (_, ctrl) => Column(
        children: [
          // Handle + header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Filtros',
                    style: AppFonts.lora(fontSize: 28, color: AppTheme.ink),
                  ),
                ),
                if (filtros.totalFiltrosActivos > 0)
                  TextButton(
                    onPressed: () {
                      notifier.limpiarFiltros();
                    },
                    child: const Text('Limpiar'),
                  ),
                IconButton(
                  tooltip: 'Cerrar filtros',
                  icon: const Icon(Icons.close_rounded, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(),

          Expanded(
            child: ListView(
              controller: ctrl,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 24),
                Text(
                  'Afina tu búsqueda',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Combina los criterios que necesites.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                // ── Ordenamiento ───────────────────────────────────────────
                _Seccion(titulo: 'Ordenar por'),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: OrdenTipo.values.map((orden) {
                    final selected = filtros.orden == orden;
                    return ChoiceChip(
                      label: Text(_labelOrden(orden)),
                      selected: selected,
                      onSelected: (_) => notifier.setOrden(orden),
                      selectedColor: AppTheme.verde,
                      labelStyle: AppFonts.inter(
                        fontSize: 13,
                        color: selected ? AppTheme.bgMarfil : AppTheme.ink,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // ── Grupo de paciente ──────────────────────────────────────
                _Seccion(titulo: 'Grupo de paciente'),
                _GrupoSelector(filtros: filtros, notifier: notifier),
                const SizedBox(height: 20),

                // ── Filtros dinámicos ──────────────────────────────────────
                opcionesAsync.when(
                  data: (opts) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FiltroMulti(
                        titulo: 'Categoría',
                        campo: CampoFiltro.categoria,
                        opciones: opts['categorias'] ?? [],
                        seleccionados: filtros.categorias,
                        onToggle: notifier.toggleCategoria,
                      ),
                      const SizedBox(height: 20),
                      _FiltroMulti(
                        titulo: 'Principio activo',
                        campo: CampoFiltro.principio,
                        opciones: opts['principios'] ?? [],
                        seleccionados: filtros.principiosActivos,
                        onToggle: notifier.togglePrincipio,
                      ),
                      const SizedBox(height: 20),
                      _FiltroMulti(
                        titulo: 'Forma farmacéutica',
                        campo: CampoFiltro.forma,
                        opciones: opts['formas'] ?? [],
                        seleccionados: filtros.formasFarmaceuticas,
                        onToggle: notifier.toggleForma,
                      ),
                      const SizedBox(height: 20),
                      _FiltroMulti(
                        titulo: 'Vía de administración',
                        campo: CampoFiltro.via,
                        opciones: opts['vias'] ?? [],
                        seleccionados: filtros.viasAdministracion,
                        onToggle: notifier.toggleVia,
                      ),
                      const SizedBox(height: 20),
                      _FiltroMulti(
                        titulo: 'Laboratorio',
                        campo: CampoFiltro.laboratorio,
                        opciones: opts['laboratorios'] ?? [],
                        seleccionados: filtros.laboratorios,
                        onToggle: notifier.toggleLaboratorio,
                      ),
                    ],
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.verde,
                      ),
                    ),
                  ),
                  error: (e, _) => const Text(
                    'No pudimos cargar los criterios. Cierra y vuelve a abrir los filtros.',
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),

          // Botón aplicar
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              8,
              24,
              MediaQuery.of(context).viewInsets.bottom +
                  MediaQuery.of(context).padding.bottom +
                  16,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ver resultados'),
              ),
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

class _Seccion extends StatelessWidget {
  final String titulo;
  const _Seccion({required this.titulo});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      titulo,
      style: AppFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTheme.muted,
        letterSpacing: 0,
      ),
    ),
  );
}

class _GrupoSelector extends StatelessWidget {
  final Filtros filtros;
  final FiltrosNotifier notifier;
  const _GrupoSelector({required this.filtros, required this.notifier});
  @override
  Widget build(BuildContext context) {
    const grupos = [
      ('adulto', 'Adultos'),
      ('adulto_mayor', 'Adultos mayores'),
      ('nino', 'Niños'),
      ('lactante', 'Lactantes'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Con dosis o pauta registrada. Revisa las edades y restricciones en cada ficha. Puedes seleccionar varios grupos.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        ...grupos.map(
          (g) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.verde,
            title: Text(g.$2, style: Theme.of(context).textTheme.bodyMedium),
            value: filtros.gruposPaciente.contains(g.$1),
            onChanged: (_) => notifier.toggleGrupo(g.$1),
          ),
        ),
      ],
    );
  }
}

class _FiltroMulti extends StatefulWidget {
  final String titulo;
  final CampoFiltro campo;
  final List<String> opciones;
  final Set<String> seleccionados;
  final void Function(String) onToggle;

  const _FiltroMulti({
    required this.titulo,
    required this.campo,
    required this.opciones,
    required this.seleccionados,
    required this.onToggle,
  });

  @override
  State<_FiltroMulti> createState() => _FiltroMultiState();
}

class _FiltroMultiState extends State<_FiltroMulti> {
  bool _expandido = false;
  static const _inicial = 8;

  @override
  Widget build(BuildContext context) {
    if (widget.opciones.isEmpty) return const SizedBox.shrink();
    final visibles = _expandido
        ? widget.opciones
        : widget.opciones.take(_inicial).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Seccion(titulo: widget.titulo),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: visibles.map((op) {
            final selected = widget.seleccionados.any(
              (v) =>
                  claveFiltro(v, widget.campo) == claveFiltro(op, widget.campo),
            );
            return FilterChip(
              label: Text(op),
              selected: selected,
              onSelected: (_) => widget.onToggle(op),
              selectedColor: AppTheme.verde,
              labelStyle: AppFonts.inter(
                fontSize: 13,
                color: selected ? AppTheme.bgMarfil : AppTheme.ink,
              ),
            );
          }).toList(),
        ),
        if (widget.opciones.length > _inicial)
          TextButton(
            onPressed: () => setState(() => _expandido = !_expandido),
            child: Text(
              _expandido
                  ? 'Ver menos'
                  : 'Ver todos (${widget.opciones.length})',
              style: AppFonts.inter(fontSize: 13, color: AppTheme.verde),
            ),
          ),
      ],
    );
  }
}
