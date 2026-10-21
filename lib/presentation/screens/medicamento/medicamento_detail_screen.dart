import '../../../core/search/filter_values.dart';
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../providers/medicamentos_provider.dart';
import '../../widgets/medicamento/image_viewer.dart';

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
          SliverPersistentHeader(
            pinned: false,
            delegate: _ImagenEncabezado(
              med: med,
              textScaler: MediaQuery.textScalerOf(context),
              width: MediaQuery.sizeOf(context).width,
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
            loadingBuilder: (_, child, progress) => progress == null
                ? child
                : SizedBox(
                    width: size,
                    height: size,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
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

class _ImagenEncabezado extends SliverPersistentHeaderDelegate {
  final MedicamentosTableData med;
  final TextScaler textScaler;
  final double width;
  _ImagenEncabezado({
    required this.med,
    required this.textScaler,
    required this.width,
  });
  double _textHeight(String text, TextStyle style, double maxWidth) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    )..layout(maxWidth: maxWidth);
    return painter.height;
  }

  @override
  double get minExtent {
    final available = (width - 128).clamp(80.0, double.infinity);
    final title = _textHeight(
      med.nombreComercial,
      AppFonts.lora(fontSize: 28, height: 1.3),
      available,
    );
    final generic = med.nombreGenerico == null
        ? 0.0
        : _textHeight(
              med.nombreGenerico!,
              AppFonts.inter(fontSize: 13, height: 1.4),
              available,
            ) +
            4;
    final category = textoCategorias(med.categoria).isEmpty
        ? 0.0
        : _textHeight(
              textoCategorias(med.categoria),
              AppFonts.inter(fontSize: 13, height: 1.4),
              available - 16,
            ) +
            16;
    return (title + generic + category).clamp(64.0, double.infinity) + 32;
  }

  @override
  double get maxExtent => minExtent + 200;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final size = lerpDouble(180, 64, t)!;
    return Material(
      color: AppTheme.bgMarfil,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppTheme.border)),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              left: lerpDouble((width - 180) / 2, 24, t),
              top: 16,
              width: size,
              height: size,
              child: med.fotoUrl == null || med.fotoUrl!.trim().isEmpty
                  ? FotoMedicamento(size: size)
                  : Tooltip(
                      message: 'Ampliar imagen',
                      child: Semantics(
                        button: true,
                        label: 'Ampliar imagen de ${med.nombreComercial}',
                        child: InkWell(
                          key: const Key('ampliar-imagen'),
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => abrirImagenMedicamento(
                            context,
                            med.fotoUrl!,
                            med.nombreComercial,
                          ),
                          child: FotoMedicamento(url: med.fotoUrl, size: size),
                        ),
                      ),
                    ),
            ),
            Positioned(
              left: lerpDouble(24, 104, t),
              right: 24,
              top: lerpDouble(212, 16, t),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    med.nombreComercial,
                    style: AppFonts.lora(
                      fontSize: 28,
                      height: 1.3,
                      color: AppTheme.ink,
                    ),
                  ),
                  if (med.nombreGenerico != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      med.nombreGenerico!,
                      style: AppFonts.inter(
                        fontSize: 13,
                        height: 1.4,
                        color: AppTheme.muted,
                      ),
                    ),
                  ],
                  if (textoCategorias(med.categoria).isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        textoCategorias(med.categoria),
                        style: AppFonts.inter(
                          fontSize: 13,
                          height: 1.4,
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
    );
  }

  @override
  bool shouldRebuild(covariant _ImagenEncabezado old) =>
      old.med != med || old.width != width || old.textScaler != textScaler;
}
