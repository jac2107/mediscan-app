import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/sync_provider.dart';

class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(syncProvider);

    return switch (sync) {
      EstadoSync.sincronizando => const SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
              strokeWidth: 1.5, color: AppTheme.muted),
        ),
      EstadoSync.actualizado => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.verde)),
            const SizedBox(width: 5),
            Text('Actualizado',
                style: GoogleFonts.inter(fontSize: 11, color: AppTheme.verde)),
          ],
        ),
      EstadoSync.offline => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.colorWarn)),
            const SizedBox(width: 5),
            Text('Sin conexión',
                style:
                    GoogleFonts.inter(fontSize: 11, color: AppTheme.colorWarn)),
          ],
        ),
      EstadoSync.error => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.colorError)),
            const SizedBox(width: 5),
            Text('Error de sync',
                style: GoogleFonts.inter(
                    fontSize: 11, color: AppTheme.colorError)),
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }
}