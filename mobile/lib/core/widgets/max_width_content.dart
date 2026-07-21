import 'package:flutter/material.dart';

/// Centers [child] within a maximum width on wide (desktop) screens instead
/// of letting content stretch edge-to-edge, which reads as unpolished on
/// large viewports. A no-op below [maxWidth].
class MaxWidthContent extends StatelessWidget {
  const MaxWidthContent({required this.child, this.maxWidth = 900, super.key});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
