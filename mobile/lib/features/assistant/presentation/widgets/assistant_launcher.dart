import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../onboarding/presentation/providers/onboarding_provider.dart';
import '../../domain/entities/assistant_language.dart';
import '../providers/assistant_language_provider.dart';
import 'assistant_chat_panel.dart';
import 'assistant_strings.dart';

/// Floating assistant entry point, meant to be layered on top of every
/// screen (see `app.dart`'s `MaterialApp.router` builder). On first open,
/// silently adopts the language chosen during onboarding — no separate
/// prompt; the chat panel's header still offers a manual override for
/// anyone who wants to switch later. Also handles the minimize/maximize
/// animation between a small FAB and the full chat panel.
class AssistantLauncher extends ConsumerStatefulWidget {
  const AssistantLauncher({super.key});

  @override
  ConsumerState<AssistantLauncher> createState() => _AssistantLauncherState();
}

class _AssistantLauncherState extends ConsumerState<AssistantLauncher> {
  bool _isOpen = false;
  bool _fabPressed = false;

  void _open() {
    if (ref.read(assistantLanguagePreferenceProvider) == null) {
      final onboardingLanguage = ref.read(onboardingLanguageProvider) ?? AssistantLanguage.english;
      ref.read(assistantLanguagePreferenceProvider.notifier).select(onboardingLanguage);
    }
    setState(() => _isOpen = true);
  }

  void _minimize() => setState(() => _isOpen = false);

  @override
  Widget build(BuildContext context) {
    final language =
        ref.watch(assistantLanguagePreferenceProvider) ??
        ref.watch(onboardingLanguageProvider) ??
        AssistantLanguage.english;
    final strings = AssistantStrings.of(language);
    final screenSize = MediaQuery.sizeOf(context);
    final panelWidth = (screenSize.width - 32).clamp(280.0, 380.0);
    final panelHeight = (screenSize.height - 120).clamp(360.0, 560.0);

    return Positioned(
      right: 16,
      bottom: 16,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        alignment: Alignment.bottomRight,
        child: _isOpen
            ? SizedBox(
                width: panelWidth,
                height: panelHeight,
                child: AssistantChatPanel(onMinimize: _minimize),
              )
            : GestureDetector(
                onTapDown: (_) => setState(() => _fabPressed = true),
                onTapUp: (_) => setState(() => _fabPressed = false),
                onTapCancel: () => setState(() => _fabPressed = false),
                child: AnimatedScale(
                  scale: _fabPressed ? 0.9 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeOut,
                  child: FloatingActionButton(
                    tooltip: strings.openAssistantTooltip,
                    onPressed: _open,
                    child: const Icon(Icons.smart_toy_outlined),
                  ),
                ),
              ),
      ),
    );
  }
}
