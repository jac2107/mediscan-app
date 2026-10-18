import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../providers/medicamentos_provider.dart';
import '../../widgets/medicamento/medicamento_card.dart';

class MedicamentoDetailScreen extends ConsumerWidget {
  final String medicamentoId;
  const MedicamentoDetailScreen({super.key, required this.medicamentoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medAsync = ref.watch(medicamentoPorIdProvider(medicamentoId));
    return medAsync.when(
      data: (med) => med == null
          ? Scaffold(appBar: AppBar(), body: const Center(child: Text('No encontrado')))
          : _DetalleView(med: med),
      loading: () => const Scaffold(
        body: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.verde),
          ),
        ),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
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
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorito() async {
    await ref.read(appDatabaseProvider).toggleFavorito(
          widget.med.id, !widget.med.esFavorito);
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
    final gruposAsync = ref.watch(gruposPorMedicamentoProvider(med.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          med.nombreComercial,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lora(fontSize: 18, color: AppTheme.ink),
        ),
        actions: [
          IconButton(
            icon: Icon(
              med.esFavorito ? Icons.star_rounded : Icons.star_outline_rounded,
              size: 20,
              color: med.esFavorito ? AppTheme.colorWarn : AppTheme.muted,
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
            Tab(text: 'Grupos'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Encabezado
          Container(
            decoration: const BoxDecoration(
              color: AppTheme.surface,
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
                        style: GoogleFonts.lora(
                            fontSize: 18,
                            color: AppTheme.ink,
                            height: 1.3),
                      ),
                      if (med.nombreGenerico != null) ...[
                        const SizedBox(height: 2),
                        Text(med.nombreGenerico!,
                            style: theme.textTheme.bodySmall),
                      ],
                      if (med.categoria != null) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.border),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            med.categoria!,
                            style: GoogleFonts.inter(
                                fontSize: 11, color: AppTheme.muted),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
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
                      _InfoBloque('Precauciones y advertencias',
                          med.precaucionesAdvertencias!),
                    ],
                    if (med.efectosAdversos != null) ...[
                      const Divider(height: 1, indent: 24),
                      _InfoBloque('Efectos adversos', med.efectosAdversos!),
                    ],
                  ],
                ),

                // Tab 4: Grupos de paciente
                gruposAsync.when(
                  data: (grupos) => ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                        child: Text(
                          'Registra la evaluación expresa. El texto de dosis no determina estos estados.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      const Divider(height: 1),
                      ...grupos.map((g) => _FilaGrupo(g)),
                    ],
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
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
          Text(label,
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: AppTheme.muted, letterSpacing: 0.3)),
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
          Text(label,
              style: GoogleFonts.lora(fontSize: 16, color: AppTheme.ink)),
          const SizedBox(height: 8),
          Text(texto,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.6)),
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
          Text(grupo,
              style: theme.textTheme.labelMedium?.copyWith(color: AppTheme.muted)),
          const SizedBox(height: 4),
          Text(
            dosis ?? 'Sin información registrada',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: dosis == null ? AppTheme.border : AppTheme.ink,
              fontStyle: dosis == null ? FontStyle.italic : FontStyle.normal,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilaGrupo extends StatelessWidget {
  final MedicamentoGruposTableData grupo;
  const _FilaGrupo(this.grupo);

  static const _labels = {
    'adulto': 'Adultos',
    'adulto_mayor': 'Adultos mayores',
    'nino': 'Niños',
    'lactante': 'Lactantes',
  };

  static const _estadoConfig = {
    'aplicable': (AppTheme.verde, 'Aplicable según la ficha registrada.'),
    'no_aplicable': (AppTheme.colorError, 'No aplicable a este grupo.'),
    'no_evaluado': (AppTheme.colorWarn, 'Sin evaluación registrada.'),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = _labels[grupo.grupo] ?? grupo.grupo;
    final (color, texto) = _estadoConfig[grupo.estado] ??
        (AppTheme.muted, grupo.estado);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(label,
                    style: theme.textTheme.labelMedium
                        ?.copyWith(color: AppTheme.muted)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(texto,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: color,
                            fontWeight: FontWeight.w600)),
                    if (grupo.observacion != null &&
                        grupo.observacion!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(grupo.observacion!,
                          style: theme.textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, indent: 24),
      ],
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
      return ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.network(
          url!,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _placeholder(),
        ),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: AppTheme.border),
        ),
        child: Icon(Icons.medication_outlined,
            size: size * 0.4, color: AppTheme.muted),
      );
}