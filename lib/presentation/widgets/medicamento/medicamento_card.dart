import 'package:flutter/material.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';

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
    final theme = Theme.of(context);
    final med = medicamento;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Ícono o foto
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: med.fotoUrl != null
                    ? Image.network(
                        med.fotoUrl!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _iconoDefault(theme),
                      )
                    : _iconoDefault(theme),
              ),
              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      med.nombre,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (med.descripcion != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        med.descripcion!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      'Cód: ${med.codigoBarras}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),

              // Favorito
              if (onFavoritoToggle != null)
                IconButton(
                  icon: Icon(
                    med.esFavorito
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: med.esFavorito ? Colors.amber : null,
                  ),
                  onPressed: onFavoritoToggle,
                  tooltip: med.esFavorito
                      ? 'Quitar favorito'
                      : 'Agregar a favoritos',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconoDefault(ThemeData theme) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.medication_rounded,
        color: theme.colorScheme.primary,
        size: 28,
      ),
    );
  }
}