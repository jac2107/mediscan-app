import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Un único control para catálogo, favoritos y detalle; mantiene su área de 48 px.
class FavoriteButton extends StatelessWidget {
  final bool selected;
  final VoidCallback? onPressed;
  const FavoriteButton({super.key, required this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) => Semantics(
    toggled: selected,
    child: IconButton(
      tooltip: selected ? 'Quitar de favoritos' : 'Guardar en favoritos',
      onPressed: onPressed,
      style:
          IconButton.styleFrom(
            minimumSize: const Size(48, 48),
            maximumSize: const Size(48, 48),
            backgroundColor: selected ? AppTheme.verde : AppTheme.card,
            disabledBackgroundColor: AppTheme.disabled,
            foregroundColor: selected ? AppTheme.bgMarfil : AppTheme.green700,
            disabledForegroundColor: AppTheme.muted,
            side: BorderSide(
              color: selected ? AppTheme.verde : AppTheme.border,
            ),
            shape: const CircleBorder(),
          ).copyWith(
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(
                color: states.contains(WidgetState.focused)
                    ? AppTheme.green700
                    : selected
                    ? AppTheme.verde
                    : AppTheme.border,
                width: states.contains(WidgetState.focused) ? 2 : 1,
              ),
            ),
          ),
      icon: AnimatedSwitcher(
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 160),
        child: Icon(
          selected ? Icons.star_rounded : Icons.star_outline_rounded,
          key: ValueKey(selected),
          size: 22,
        ),
      ),
    ),
  );
}
