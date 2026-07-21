import 'package:flutter/material.dart';

import '../../../assistant/domain/entities/assistant_language.dart';
import '../widgets/glass_card.dart';
import '../widgets/premium_button.dart';

/// Third and final onboarding step: title, short description, and a large
/// "Continue" button that hands off to the main app. Text follows
/// [language] — the choice made one step earlier — since the app's own
/// `MaterialApp.locale` doesn't take effect until onboarding completes.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
    required this.language,
    required this.onContinue,
  });

  final AssistantLanguage language;
  final VoidCallback onContinue;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeStrings {
  const _WelcomeStrings({
    required this.title,
    required this.description,
    required this.continueLabel,
  });

  final String title;
  final String description;
  final String continueLabel;

  static _WelcomeStrings of(AssistantLanguage language) => switch (language) {
    AssistantLanguage.english => const _WelcomeStrings(
      title: 'Welcome to Nöbetçi Eczane+',
      description:
          'Find the nearest on-duty pharmacy in seconds — live locations, '
          'opening hours, and directions, wherever you are in Istanbul.',
      continueLabel: 'Continue',
    ),
    AssistantLanguage.turkish => const _WelcomeStrings(
      title: "Nöbetçi Eczane+'a Hoş Geldiniz",
      description:
          'En yakın nöbetçi eczaneyi saniyeler içinde bulun — İstanbul\'un her '
          'yerinde canlı konumlar, açılış saatleri ve yol tarifi.',
      continueLabel: 'Devam Et',
    ),
    AssistantLanguage.arabic => const _WelcomeStrings(
      title: 'مرحبًا بك في Nöbetçi Eczane+',
      description:
          'اعثر على أقرب صيدلية مناوبة في ثوانٍ — مواقع مباشرة وساعات عمل واتجاهات '
          'أينما كنت في إسطنبول.',
      continueLabel: 'متابعة',
    ),
  };
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
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
    final strings = _WelcomeStrings.of(widget.language);

    return Directionality(
      textDirection: widget.language.isRightToLeft
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                scheme.secondaryContainer.withValues(alpha: 0.5),
                scheme.surface,
              ],
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
                              backgroundColor: scheme.primary.withValues(
                                alpha: 0.15,
                              ),
                              child: Icon(
                                Icons.local_pharmacy_rounded,
                                color: scheme.primary,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              strings.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              strings.description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
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
                    child: PremiumButton(
                      label: strings.continueLabel,
                      onPressed: widget.onContinue,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
