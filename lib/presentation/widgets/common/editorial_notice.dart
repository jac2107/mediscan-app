import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EditorialNotice extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color color;
  final Widget? action;
  final bool busy;
  const EditorialNotice({
    super.key,
    required this.icon,
    required this.message,
    this.color = AppTheme.muted,
    this.action,
    this.busy = false,
  });
  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (busy)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.verde,
                  ),
                )
              else
                Icon(icon, color: color, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: color),
                ),
              ),
            ],
          ),
          if (action != null)
            Padding(padding: const EdgeInsets.only(top: 4), child: action!),
        ],
      ),
    ),
  );
}
