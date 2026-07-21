import 'package:flutter/material.dart';

import '../../domain/entities/assistant_language.dart';
import 'assistant_strings.dart';

/// Shown the first time the assistant is opened (and again whenever the
/// user taps "change language"). Not dismissible on first launch via
/// barrier tap — the user must make a choice to proceed, per requirements.
class AssistantLanguagePicker extends StatelessWidget {
  const AssistantLanguagePicker({required this.currentLanguage, this.allowCancel = false, super.key});

  /// The already-selected language (if any), used purely to localize the
  /// picker's own chrome when re-opened via "change language". `null` on
  /// first launch, when no language has been chosen yet.
  final AssistantLanguage? currentLanguage;
  final bool allowCancel;

  static Future<AssistantLanguage?> show(
    BuildContext context, {
    AssistantLanguage? currentLanguage,
    bool allowCancel = false,
  }) {
    return showDialog<AssistantLanguage>(
      context: context,
      barrierDismissible: allowCancel,
      builder: (context) =>
          AssistantLanguagePicker(currentLanguage: currentLanguage, allowCancel: allowCancel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AssistantStrings.of(currentLanguage ?? AssistantLanguage.english);

    return AlertDialog(
      title: Text(strings.chooseLanguageTitle),
      content: Text(strings.chooseLanguageBody),
      actions: [
        if (allowCancel)
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(strings.cancel)),
        ...AssistantLanguage.values.map(
          (language) => TextButton(
            onPressed: () => Navigator.of(context).pop(language),
            child: Text(language.nativeName),
          ),
        ),
      ],
    );
  }
}
