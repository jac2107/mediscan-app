import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../medicamento/medicamento_card.dart'; // FotoMedicamento
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
    final principios = AppDatabase.jsonToList(med.principiosActivos);
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FotoMedicamento(url: med.fotoUrl, size: 48),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    med.nombreComercial,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (med.nombreGenerico != null) ...[
                    const SizedBox(height: 1),
                    Text(
                      med.nombreGenerico!,
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (principios.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      principios.take(2).join(' · '),
                      style: GoogleFonts.inter(
                          fontSize: 11, color: AppTheme.muted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (med.categoria != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      med.categoria!,
                      style: GoogleFonts.inter(
                          fontSize: 11, color: AppTheme.border),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            if (onFavoritoToggle != null)
              GestureDetector(
                onTap: onFavoritoToggle,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    med.esFavorito
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: 18,
                    color: med.esFavorito ? AppTheme.colorWarn : AppTheme.border,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}