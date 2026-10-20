import 'package:flutter/material.dart';
import 'package:medicamentos_app/core/theme/app_fonts.dart';
import 'package:medicamentos_app/core/theme/app_theme.dart';

class AppErrorWidget extends StatelessWidget {
  final String mensaje;
  final VoidCallback? onReintentar;

  const AppErrorWidget({
    super.key,
    required this.mensaje,
    this.onReintentar,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline_rounded,
                size: 28, color: AppTheme.colorError),
            const SizedBox(height: 12),
            Text(
              'Algo salió mal',
              style: AppFonts.lora(fontSize: 18, color: AppTheme.ink),
            ),
            const SizedBox(height: 6),
            Text(
              mensaje,
              style: AppFonts.inter(
                  fontSize: 14, color: AppTheme.muted, height: 1.5),
            ),
            if (onReintentar != null) ...[
              const SizedBox(height: 20),
              TextButton(
                onPressed: onReintentar,
                child: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
