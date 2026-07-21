import 'package:flutter/material.dart';

/// Three dots that bounce in sequence, shown while waiting for the
/// assistant's reply.
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return SizedBox(
      width: 36,
      height: 16,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              final t = (_controller.value - index * 0.2) % 1.0;
              final bounce = (t < 0.5 ? t : 1 - t) * 2; // 0..1..0 triangle wave
              return Transform.translate(
                offset: Offset(0, -4 * bounce),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
