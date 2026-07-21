import 'package:flutter/material.dart';

import '../../../assistant/domain/entities/assistant_language.dart';
import '../widgets/glass_card.dart';

/// Second onboarding step: three large language cards (Arabic, English,
/// Turkish). Cards stagger-fade/scale in on entry and give a micro-scale
/// "press" response on tap before handing off the selection.
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key, required this.onSelected});

  final ValueChanged<AssistantLanguage> onSelected;

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
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

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [scheme.surface, scheme.primaryContainer.withValues(alpha: 0.35)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                _EntryFade(
                  controller: _controller,
                  interval: const Interval(0.0, 0.5, curve: Curves.easeOut),
                  child: Text(
                    'Choose your language',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 8),
                _EntryFade(
                  controller: _controller,
                  interval: const Interval(0.1, 0.6, curve: Curves.easeOut),
                  child: Text(
                    'Dilinizi seçin • اختر لغتك',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
                const Spacer(),
                for (final (index, language) in AssistantLanguage.values.indexed) ...[
                  _EntryFade(
                    controller: _controller,
                    interval: Interval(0.15 + index * 0.15, 0.7 + index * 0.15, curve: Curves.easeOutCubic),
                    slideFrom: 0.08,
                    child: _LanguageCard(
                      language: language,
                      onTap: () => widget.onSelected(language),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatefulWidget {
  const _LanguageCard({required this.language, required this.onTap});

  final AssistantLanguage language;
  final VoidCallback onTap;

  @override
  State<_LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<_LanguageCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: GlassCard(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: scheme.primary.withValues(alpha: 0.15),
                child: Text(
                  widget.language.nativeName.substring(0, 1),
                  style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.language.nativeName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 18, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

/// Staggered fade + slight upward slide, driven by a shared
/// [AnimationController] via an [Interval] so entries cascade in.
class _EntryFade extends StatelessWidget {
  const _EntryFade({
    required this.controller,
    required this.interval,
    required this.child,
    this.slideFrom = 0.03,
  });

  final AnimationController controller;
  final Interval interval;
  final Widget child;
  final double slideFrom;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: controller, curve: interval);
    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) {
        return Opacity(
          opacity: curved.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - curved.value.clamp(0.0, 1.0)) * slideFrom * 100),
            child: child,
          ),
        );
      },
    );
  }
}
