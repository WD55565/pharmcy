import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/assistant_language.dart';
import '../providers/assistant_language_provider.dart';
import 'assistant_chat_panel.dart';
import 'assistant_language_picker.dart';
import 'assistant_strings.dart';

/// Floating assistant entry point, meant to be layered on top of every
/// screen (see `app.dart`'s `MaterialApp.router` builder). Handles the
/// first-open language prompt and the minimize/maximize animation between
/// a small FAB and the full chat panel.
class AssistantLauncher extends ConsumerStatefulWidget {
  const AssistantLauncher({super.key});

  @override
  ConsumerState<AssistantLauncher> createState() => _AssistantLauncherState();
}

class _AssistantLauncherState extends ConsumerState<AssistantLauncher> {
  bool _isOpen = false;

  Future<void> _open() async {
    final existing = ref.read(assistantLanguagePreferenceProvider);
    if (existing == null) {
      final chosen = await AssistantLanguagePicker.show(context, currentLanguage: null);
      if (!mounted || chosen == null) return;
      ref.read(assistantLanguagePreferenceProvider.notifier).select(chosen);
    }
    if (mounted) setState(() => _isOpen = true);
  }

  void _minimize() => setState(() => _isOpen = false);

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(assistantLanguagePreferenceProvider) ?? AssistantLanguage.english;
    final strings = AssistantStrings.of(language);
    final screenSize = MediaQuery.sizeOf(context);
    final panelWidth = (screenSize.width - 32).clamp(280.0, 380.0);
    final panelHeight = (screenSize.height - 120).clamp(360.0, 560.0);

    return Positioned(
      right: 16,
      bottom: 16,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        alignment: Alignment.bottomRight,
        child: _isOpen
            ? SizedBox(
                width: panelWidth,
                height: panelHeight,
                child: AssistantChatPanel(onMinimize: _minimize),
              )
            : FloatingActionButton(
                tooltip: strings.openAssistantTooltip,
                onPressed: _open,
                child: const Icon(Icons.smart_toy_outlined),
              ),
      ),
    );
  }
}
