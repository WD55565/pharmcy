import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../assistant/domain/entities/assistant_language.dart';
import '../providers/onboarding_provider.dart';
import 'language_selection_screen.dart';
import 'splash_screen.dart';
import 'welcome_screen.dart';

enum _OnboardingStep { splash, language, welcome }

/// Sequences the three first-visit steps — splash, language selection,
/// welcome — behind a single route, cross-fading/scaling between them so
/// the transition feels like one continuous cinematic flow rather than
/// three separate page pushes. Calls [onComplete] once the user taps
/// Continue.
class OnboardingFlowScreen extends ConsumerStatefulWidget {
  const OnboardingFlowScreen({super.key, required this.onComplete});

  final VoidCallback onComplete;

  @override
  ConsumerState<OnboardingFlowScreen> createState() =>
      _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  _OnboardingStep _step = _OnboardingStep.splash;
  AssistantLanguage _selectedLanguage = AssistantLanguage.english;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween(begin: 0.97, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: switch (_step) {
        _OnboardingStep.splash => SplashScreen(
          key: const ValueKey('splash'),
          onFinished: () => setState(() => _step = _OnboardingStep.language),
        ),
        _OnboardingStep.language => LanguageSelectionScreen(
          key: const ValueKey('language'),
          onSelected: _selectLanguage,
        ),
        _OnboardingStep.welcome => WelcomeScreen(
          key: const ValueKey('welcome'),
          language: _selectedLanguage,
          onContinue: _complete,
        ),
      },
    );
  }

  Future<void> _selectLanguage(AssistantLanguage language) async {
    await ref.read(onboardingLanguageProvider.notifier).select(language);
    if (!mounted) return;
    setState(() {
      _selectedLanguage = language;
      _step = _OnboardingStep.welcome;
    });
  }

  Future<void> _complete() async {
    await ref.read(onboardingCompletedProvider.notifier).complete();
    widget.onComplete();
  }
}
