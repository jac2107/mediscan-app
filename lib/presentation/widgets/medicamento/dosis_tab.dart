import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../common/editorial_components.dart';

/// Se muestra el texto clínico íntegro: no se extraen cifras ni se calculan intervalos.
class DosisTab extends StatelessWidget {
  final String? adultos;
  final String? mayores;
  final String? pediatrica;
  final String? lactantes;
  const DosisTab({
    super.key,
    this.adultos,
    this.mayores,
    this.pediatrica,
    this.lactantes,
  });
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'CONSULTA POR EDAD',
        style: TextStyle(
          fontSize: 11,
          letterSpacing: 1.5,
          color: AppTheme.green700,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 8),
      const EditorialTitle('Dosis', 'recomendada'),
      const SizedBox(height: 24),
      DoseCard(
        group: 'Adultos',
        text: adultos,
        featured: true,
        icon: Icons.person_outline_rounded,
      ),
      const SizedBox(height: 14),
      DoseCard(
        group: 'Adultos mayores',
        text: mayores,
        icon: Icons.elderly_outlined,
        sage: true,
      ),
      const SizedBox(height: 14),
      LayoutBuilder(
        builder: (context, constraints) {
          final children = [
            DoseCard(
              group: 'Niños',
              text: pediatrica,
              icon: Icons.child_care_outlined,
            ),
            DoseCard(
              group: 'Lactantes',
              text: lactantes,
              icon: Icons.child_friendly_outlined,
            ),
          ];
          if (constraints.maxWidth < 380 ||
              MediaQuery.textScalerOf(context).scale(1) > 1.3) {
            return Column(
              children: [children[0], const SizedBox(height: 14), children[1]],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: children[0]),
              const SizedBox(width: 14),
              Expanded(child: children[1]),
            ],
          );
        },
      ),
      const SizedBox(height: 24),
    ],
  );
}

class DoseCard extends StatelessWidget {
  final String group;
  final String? text;
  final bool featured;
  final bool sage;
  final IconData icon;
  const DoseCard({
    super.key,
    required this.group,
    this.text,
    this.featured = false,
    this.sage = false,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    final content = text == null || text!.trim().isEmpty
        ? 'Sin información registrada'
        : text!;
    final foreground = featured ? AppTheme.bgMarfil : AppTheme.ink;
    return Reveal(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: featured
              ? AppTheme.verde
              : sage
              ? const Color(0xFFE3ECE5)
              : AppTheme.card,
          borderRadius: BorderRadius.circular(featured ? 32 : 28),
          border: Border.all(
            color: featured ? AppTheme.verde : AppTheme.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 26,
              color: featured ? AppTheme.mint : AppTheme.green700,
            ),
            const SizedBox(height: 18),
            Text(
              group,
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: featured ? 32 : 25,
                height: 1.15,
                color: foreground,
              ),
            ),
            const SizedBox(height: 14),
            if (featured)
              Container(height: 1, color: AppTheme.mint.withValues(alpha: .3))
            else
              const DashedRule(),
            const SizedBox(height: 14),
            SelectableText(
              content,
              style: TextStyle(fontSize: 15, height: 1.65, color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
