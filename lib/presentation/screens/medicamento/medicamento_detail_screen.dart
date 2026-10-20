import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../providers/medicamentos_provider.dart';

class MedicamentoDetailScreen extends ConsumerWidget {
  final String medicamentoId;
  const MedicamentoDetailScreen({super.key, required this.medicamentoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medAsync = ref.watch(medicamentoPorIdProvider(medicamentoId));
    return medAsync.when(
      data: (med) => med == null
          ? Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('No encontrado')),
            )
          : _DetalleView(med: med),
      loading: () => const Scaffold(
        body: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppTheme.verde,
            ),
          ),
        ),
      ),
      error: (_, __) => Scaffold(
        appBar: AppBar(title: const Text('Ficha del medicamento')),
        body: const Center(
          child: Text('No pudimos abrir la ficha. Vuelve a intentarlo.'),
        ),
      ),
    );
  }
}

class _DetalleView extends ConsumerStatefulWidget {
  final MedicamentosTableData med;
  const _DetalleView({required this.med});

  @override
  ConsumerState<_DetalleView> createState() => _DetalleViewState();
}

class _DetalleViewState extends ConsumerState<_DetalleView>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorito() async {
    await ref
        .read(appDatabaseProvider)
        .toggleFavorito(widget.med.id, !widget.med.esFavorito);
    ref.invalidate(todosMedicamentosProvider);
    ref.invalidate(favoritosProvider);
    ref.invalidate(medicamentoPorIdProvider(widget.med.id));
  }

  @override
  Widget build(BuildContext context) {
    final med = widget.med;
    final theme = Theme.of(context);
    final principios = AppDatabase.jsonToList(med.principiosActivos);
    final formas = AppDatabase.jsonToList(med.formasFarmaceuticas);
    final vias = AppDatabase.jsonToList(med.viasAdministracion);
    final laboratorios = AppDatabase.jsonToList(med.laboratorios);
    final concentraciones = AppDatabase.jsonToList(med.concentraciones);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha del medicamento'),
        actions: [
          IconButton(
            tooltip:
                med.esFavorito ? 'Quitar de favoritos' : 'Guardar en favoritos',
            icon: Icon(
              med.esFavorito ? Icons.star_rounded : Icons.star_outline_rounded,
              size: 20,
              color: med.esFavorito ? AppTheme.verde : AppTheme.muted,
            ),
            onPressed: _toggleFavorito,
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Ficha'),
            Tab(text: 'Dosis'),
            Tab(text: 'Seguridad'),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: // Encabezado
                Container(
              decoration: const BoxDecoration(
                color: AppTheme.bgMarfil,
                border: Border(bottom: BorderSide(color: AppTheme.border)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FotoMedicamento(url: med.fotoUrl, size: 64),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          med.nombreComercial,
                          style: AppFonts.lora(
                            fontSize: 28,
                            color: AppTheme.ink,
                            height: 1.3,
                          ),
                        ),
                        if (med.nombreGenerico != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            med.nombreGenerico!,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                        if (med.categoria != null) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.border),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              med.categoria!,
                              style: AppFonts.inter(
                                fontSize: 13,
                                color: AppTheme.muted,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            // Tab 1: Ficha
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _InfoRow('Código', med.codigoInterno),
                if (principios.isNotEmpty)
                  _InfoRow('Principios activos', principios.join(', ')),
                if (concentraciones.isNotEmpty)
                  _InfoRow('Concentraciones', concentraciones.join(', ')),
                if (formas.isNotEmpty)
                  _InfoRow('Formas farmacéuticas', formas.join(', ')),
                if (med.presentacion != null)
                  _InfoRow('Presentación', med.presentacion!),
                if (vias.isNotEmpty)
                  _InfoRow('Vías de administración', vias.join(', ')),
                if (laboratorios.isNotEmpty)
                  _InfoRow('Laboratorios', laboratorios.join(', ')),
                if (med.fechaRevision != null)
                  _InfoRow('Última revisión', med.fechaRevision!),
                if (med.composicionCompleta != null) ...[
                  const Divider(indent: 24),
                  _InfoRow('Composición completa', med.composicionCompleta!),
                ],
                if (med.indicacionesTexto != null) ...[
                  const Divider(indent: 24),
                  _InfoBloque('Indicaciones', med.indicacionesTexto!),
                ],
              ],
            ),

            // Tab 2: Dosis
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _FilaDosis('Adultos', med.dosisAdultos),
                const Divider(height: 1, indent: 24),
                _FilaDosis('Adultos mayores', med.dosisAdultosMayores),
                const Divider(height: 1, indent: 24),
                _FilaDosis('Niños', med.dosisPediatrica),
                const Divider(height: 1, indent: 24),
                _FilaDosis('Lactantes', med.dosisLactantes),
              ],
            ),

            // Tab 3: Seguridad
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                if (med.contraindicaciones != null)
                  _InfoBloque('Contraindicaciones', med.contraindicaciones!),
                if (med.precaucionesAdvertencias != null) ...[
                  const Divider(height: 1, indent: 24),
                  _InfoBloque(
                    'Precauciones y advertencias',
                    med.precaucionesAdvertencias!,
                  ),
                ],
                if (med.efectosAdversos != null) ...[
                  const Divider(height: 1, indent: 24),
                  _InfoBloque('Efectos adversos', med.efectosAdversos!),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widgets de sección ────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final String label;
  final String valor;
  const _InfoRow(this.label, this.valor);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppTheme.muted,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 3),
          Text(valor, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _InfoBloque extends StatelessWidget {
  final String label;
  final String texto;
  const _InfoBloque(this.label, this.texto);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppFonts.lora(fontSize: 21, color: AppTheme.ink)),
          const SizedBox(height: 8),
          Text(texto, style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
        ],
      ),
    );
  }
}

class _FilaDosis extends StatelessWidget {
  final String grupo;
  final String? dosis;
  const _FilaDosis(this.grupo, this.dosis);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            grupo,
            style: theme.textTheme.labelMedium?.copyWith(color: AppTheme.muted),
          ),
          const SizedBox(height: 4),
          Text(
            dosis == null || dosis!.trim().isEmpty
                ? 'Sin información registrada'
                : dosis!,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: dosis == null ? AppTheme.muted : AppTheme.ink,
              fontStyle: FontStyle.normal,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Foto reutilizable ─────────────────────────────────────────────────────────

class FotoMedicamento extends StatelessWidget {
  final String? url;
  final double size;
  const FotoMedicamento({super.key, this.url, this.size = 48});

  @override
  Widget build(BuildContext context) {
    if (url != null && url!.isNotEmpty) {
      return Semantics(
        label: 'Fotografía del medicamento',
        image: true,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            url!,
            width: size,
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _placeholder(),
          ),
        ),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => Tooltip(
        message: 'Fotografía no disponible',
        child: Semantics(
          label: 'Fotografía no disponible',
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: Icon(
              Icons.medication_outlined,
              size: size * 0.4,
              color: AppTheme.muted,
            ),
          ),
        ),
      );
}
