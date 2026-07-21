import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Cinematic first frame: a soft gradient backdrop, a logo mark that
/// scales/fades in while gently rotating in 3D (a subtle perspective tilt,
/// not a full spin), then hands off to [onFinished]. Pure
/// `AnimationController`/`Transform` — no extra animation dependency.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<double> _tilt;
  late final Animation<double> _glowFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));

    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.08).chain(CurveTween(curve: Curves.easeOutCubic)), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 20),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 25),
    ]).animate(_controller);

    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
    );

    _tilt = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: -0.35, end: 0.06).chain(CurveTween(curve: Curves.easeOutCubic)), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 0.06, end: 0.0).chain(CurveTween(curve: Curves.easeOut)), weight: 45),
    ]).animate(_controller);

    _glowFade = CurvedAnimation(parent: _controller, curve: const Interval(0.15, 1.0, curve: Curves.easeOut));

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 350), widget.onFinished);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [scheme.primaryContainer, scheme.surface, scheme.secondaryContainer],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fade,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015)
                    ..rotateX(_tilt.value)
                    ..rotateY(-_tilt.value * 0.6)
                    ..scaleByDouble(_scale.value, _scale.value, _scale.value, 1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Glow(intensity: _glowFade.value, color: scheme.primary),
                      const SizedBox(height: 24),
                      Text(
                        'Nöbetçi Eczane+',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Opacity(
                        opacity: _fade.value,
                        child: Text(
                          'Nearby on-duty pharmacies, always in reach',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// The animated logo mark itself: a soft-shadowed circular badge with a
/// pharmacy cross, sitting inside a slowly-pulsing glow.
class _Glow extends StatelessWidget {
  const _Glow({required this.intensity, required this.color});

  final double intensity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final pulse = 0.85 + 0.15 * math.sin(intensity * math.pi);
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.35 * intensity), color.withValues(alpha: 0.0)],
        ),
      ),
      child: Center(
        child: Container(
          width: 84 * pulse,
          height: 84 * pulse,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.45 * intensity),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.local_pharmacy_rounded, color: Colors.white, size: 42),
        ),
      ),
    );
  }
}
