import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EditorialTitle extends StatelessWidget {
  final String lead;
  final String emphasis;
  final double size;
  const EditorialTitle(this.lead, this.emphasis, {super.key, this.size = 32});
  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text.rich(
      TextSpan(
        text: '$lead ',
        children: [
          TextSpan(
            text: emphasis,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: AppTheme.green700,
            ),
          ),
        ],
      ),
      style: TextStyle(
        fontFamily: 'Lora',
        fontSize: size,
        height: 1.2,
        color: AppTheme.ink,
      ),
    ),
  );
}

class DataChip extends StatelessWidget {
  final String text;
  const DataChip(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: AppTheme.surface,
      borderRadius: BorderRadius.circular(AppTheme.radiusChip),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: AppTheme.green700,
      ),
    ),
  );
}

class DashedRule extends StatelessWidget {
  const DashedRule({super.key});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) => Row(
      children: List.generate(
        (constraints.maxWidth / 8).floor(),
        (_) => Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(height: 1, color: AppTheme.border),
          ),
        ),
      ),
    ),
  );
}

/// Solo desvanece la entrada: no cambia el tamaño ni desplaza otros elementos.
class Reveal extends StatelessWidget {
  final Widget child;
  const Reveal({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: child,
      builder: (_, value, content) => Opacity(opacity: value, child: content),
    );
  }
}
