import '../../../core/search/filter_values.dart';

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../screens/medicamento/medicamento_detail_screen.dart';
import '../common/editorial_components.dart';
import '../common/favorite_button.dart';

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
    final principios = AppDatabase.jsonToList(med.principiosActivos);
    final datos = [
      ...AppDatabase.jsonToList(med.concentraciones),
      ...AppDatabase.jsonToList(med.formasFarmaceuticas),
      if (med.presentacion?.isNotEmpty == true) med.presentacion!,
    ];
    final vias = AppDatabase.jsonToList(med.viasAdministracion);
    return Reveal(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        child: Material(
          color: AppTheme.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: const BorderSide(color: AppTheme.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FotoMedicamento(url: med.fotoUrl, size: 76),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              med.codigoInterno,
                              style: const TextStyle(
                                color: AppTheme.muted,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              med.nombreComercial,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontSize: 22,
                                    height: 1.15,
                                    letterSpacing: -.3,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            if (med.nombreGenerico?.isNotEmpty == true)
                              Text(
                                med.nombreGenerico!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            if (principios.isNotEmpty &&
                                principios.join(' · ').toLowerCase() !=
                                    med.nombreGenerico?.toLowerCase())
                              Text(
                                (principios.isNotEmpty
                                        ? principios.join(' · ')
                                        : med.nombreGenerico!)
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.green700,
                                  fontSize: 10,
                                  height: 1.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .7,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (onFavoritoToggle != null)
                        FavoriteButton(
                          selected: med.esFavorito,
                          onPressed: onFavoritoToggle,
                        ),
                    ],
                  ),
                  if (datos.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: datos.map((d) => DataChip(d)).toList(),
                    ),
                  ],
                  const SizedBox(height: 16),
                  const DashedRule(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          [
                            if (textoCategorias(med.categoria).isNotEmpty)
                              textoCategorias(med.categoria),
                            ...vias,
                          ].join(' · '),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.muted,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const ExcludeSemantics(
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppTheme.verde,
                          child: Icon(
                            Icons.north_east_rounded,
                            size: 18,
                            color: AppTheme.bgMarfil,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
