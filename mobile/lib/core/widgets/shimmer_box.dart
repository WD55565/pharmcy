import 'package:flutter/material.dart';

/// A single shimmering placeholder block, used to build skeleton loading
/// states. Implemented with a plain repeating [AnimationController] driving
/// a moving gradient sweep — no external shimmer package required.
class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    this.width,
    this.height = 12,
    this.borderRadius = 8,
    super.key,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlight = Theme.of(context).colorScheme.surface;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final sweep = _controller.value * 2 - 1; // -1 .. 1
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(sweep - 0.3, 0),
              end: Alignment(sweep + 0.3, 0),
              colors: [base, highlight, base],
            ),
          ),
        );
      },
    );
  }
}
