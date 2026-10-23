import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Solo anima cuando el reconocedor está escuchando. No inventa transcripciones.
class VoiceMotion extends StatefulWidget {
  final bool active;
  final Duration duration;
  final Widget Function(BuildContext, double) builder;
  const VoiceMotion({
    super.key,
    required this.active,
    required this.builder,
    this.duration = const Duration(milliseconds: 2600),
  });
  @override
  State<VoiceMotion> createState() => _VoiceMotionState();
}

class _VoiceMotionState extends State<VoiceMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  void _update() {
    if (widget.active && !MediaQuery.disableAnimationsOf(context)) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(VoiceMotion oldWidget) {
    super.didUpdateWidget(oldWidget);
    _update();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (_, __) => widget.builder(context, _controller.value),
  );
}

class VoiceButton extends StatelessWidget {
  final bool listening;
  final bool busy;
  final VoidCallback? onPressed;
  const VoiceButton({
    super.key,
    required this.listening,
    required this.busy,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) => VoiceMotion(
    active: listening,
    duration: const Duration(milliseconds: 1600),
    builder: (_, phase) => SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: [
          if (listening && !MediaQuery.disableAnimationsOf(context))
            for (var i = 0; i < 2; i++)
              Transform.scale(
                scale: 1 + ((phase + i * .5) % 1) * .24,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.verde.withValues(
                        alpha: .5 * (1 - (phase + i * .5) % 1),
                      ),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
          Material(
            color: AppTheme.verde,
            shape: const CircleBorder(),
            child: IconButton(
              tooltip: listening
                  ? 'Finalizar dictado'
                  : 'Dictar nombre del medicamento',
              onPressed: busy ? null : onPressed,
              style: IconButton.styleFrom(foregroundColor: AppTheme.bgMarfil)
                  .copyWith(
                    side: WidgetStateProperty.resolveWith(
                      (states) => BorderSide(
                        color: states.contains(WidgetState.focused)
                            ? AppTheme.mint
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
              constraints: const BoxConstraints.tightFor(width: 56, height: 56),
              icon: busy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.bgMarfil,
                      ),
                    )
                  : Icon(
                      listening ? Icons.stop_rounded : Icons.mic_none_outlined,
                      color: AppTheme.bgMarfil,
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}

class VoicePanel extends StatelessWidget {
  final String transcript;
  final double level;
  final VoidCallback onCancel;
  const VoicePanel({
    super.key,
    required this.transcript,
    required this.level,
    required this.onCancel,
  });
  @override
  Widget build(BuildContext context) => VoiceMotion(
    active: true,
    builder: (_, phase) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.verde,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.circle, color: AppTheme.mint, size: 7),
              Text(
                'MICRÓFONO ACTIVO',
                style: TextStyle(
                  color: AppTheme.mint,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  for (var i = 0; i < 3; i++)
                    Transform.scale(
                      scale: 1 + ((phase + i / 3) % 1) * 1.5,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.mint.withValues(
                              alpha: .45 * (1 - (phase + i / 3) % 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF245944),
                    ),
                    child: const Icon(
                      Icons.mic_none_outlined,
                      color: AppTheme.mint,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 52,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(15, (i) {
                  final wave =
                      .2 +
                      .8 * ((math.sin(phase * math.pi * 4.7 + i * .7) + 1) / 2);
                  return Container(
                    width: 4,
                    height: 10 + 42 * wave * (.25 + level * .75),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.mint,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Di el nombre del medicamento',
            style: TextStyle(
              fontFamily: 'Lora',
              fontSize: 26,
              height: 1.15,
              color: AppTheme.bgMarfil,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'TRANSCRIPCIÓN',
            style: TextStyle(
              color: AppTheme.mint,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Semantics(
            liveRegion: true,
            child: Text(
              transcript.isEmpty ? 'Esperando tu voz…' : transcript,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.bgMarfil,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onCancel,
            style: TextButton.styleFrom(foregroundColor: AppTheme.mint),
            icon: const Icon(Icons.close_rounded, size: 18),
            label: const Text('Cancelar dictado'),
          ),
        ],
      ),
    ),
  );
}
