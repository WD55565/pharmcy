import 'package:flutter/material.dart';

import '../widgets/glass_card.dart';
import '../widgets/premium_button.dart';

/// Third and final onboarding step: title, short description, and a large
/// "Continue" button that hands off to the main app.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    final scale = Tween(begin: 0.92, end: 1.0).animate(fade);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [scheme.secondaryContainer.withValues(alpha: 0.5), scheme.surface],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                FadeTransition(
                  opacity: fade,
                  child: ScaleTransition(
                    scale: scale,
                    child: GlassCard(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: scheme.primary.withValues(alpha: 0.15),
                            child: Icon(Icons.local_pharmacy_rounded, color: scheme.primary, size: 32),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Welcome to Nöbetçi Eczane+',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Find the nearest on-duty pharmacy in seconds — live locations, '
                            'opening hours, and directions, wherever you are in Istanbul.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                FadeTransition(
                  opacity: fade,
                  child: PremiumButton(label: 'Continue', onPressed: widget.onContinue),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
