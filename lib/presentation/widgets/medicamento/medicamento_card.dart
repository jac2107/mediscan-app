import '../../../core/search/filter_values.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../screens/medicamento/medicamento_detail_screen.dart';

class MedicamentoCard extends StatelessWidget {
  final MedicamentosTableData medicamento;
  final VoidCallback onTap;
  final VoidCallback? onFavoritoToggle;
  const MedicamentoCard({
    super.key,
    required this.medicamento,
    required this.onTap,
    this.onFavoritoToggle,
  });
  @override
  Widget build(BuildContext context) {
    final med = medicamento;
    final theme = Theme.of(context);
    final concentraciones = AppDatabase.jsonToList(med.concentraciones);
    final formas = AppDatabase.jsonToList(med.formasFarmaceuticas);
    final vias = AppDatabase.jsonToList(med.viasAdministracion);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: AppTheme.bgMarfil,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppTheme.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FotoMedicamento(url: med.fotoUrl, size: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        med.nombreComercial,
                        style: theme.textTheme.titleLarge,
                      ),
                      if (med.nombreGenerico?.isNotEmpty == true)
                        Text(
                          med.nombreGenerico!,
                          style: theme.textTheme.bodySmall,
                        ),
                      if (concentraciones.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            concentraciones.join(' · '),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      if (formas.isNotEmpty)
                        Text(
                          formas.join(' · '),
                          style: theme.textTheme.bodyMedium,
                        ),
                      if (med.presentacion?.isNotEmpty == true)
                        Text(
                          med.presentacion!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      if (textoCategorias(med.categoria).isNotEmpty ||
                          vias.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            [
                              if (textoCategorias(med.categoria).isNotEmpty)
                                textoCategorias(med.categoria),
                              ...vias,
                            ].join(' · '),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.chevron_right_outlined,
                        size: 20,
                        color: AppTheme.muted,
                      ),
                    ),
                    if (onFavoritoToggle != null)
                      IconButton(
                        tooltip: med.esFavorito
                            ? 'Quitar de favoritos'
                            : 'Guardar en favoritos',
                        onPressed: onFavoritoToggle,
                        icon: Icon(
                          med.esFavorito
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color:
                              med.esFavorito ? AppTheme.verde : AppTheme.muted,
                          size: 22,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
