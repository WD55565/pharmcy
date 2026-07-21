import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/assistant_language.dart';
import '../providers/assistant_conversation_provider.dart';
import '../providers/assistant_language_provider.dart';
import 'assistant_language_picker.dart';
import 'assistant_strings.dart';
import 'chat_message_bubble.dart';
import 'typing_indicator.dart';

/// The expanded chat window: header (title, change-language, clear,
/// minimize), scrollable message history, typing indicator, and input.
class AssistantChatPanel extends ConsumerStatefulWidget {
  const AssistantChatPanel({required this.onMinimize, super.key});

  final VoidCallback onMinimize;

  @override
  ConsumerState<AssistantChatPanel> createState() => _AssistantChatPanelState();
}

class _AssistantChatPanelState extends ConsumerState<AssistantChatPanel> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send() async {
    final text = _inputController.text;
    if (text.trim().isEmpty) return;
    _inputController.clear();
    await ref.read(assistantConversationProvider.notifier).sendMessage(text);
    _scrollToBottom();
  }

  Future<void> _changeLanguage(AssistantLanguage current) async {
    final chosen = await AssistantLanguagePicker.show(
      context,
      currentLanguage: current,
      allowCancel: true,
    );
    if (chosen != null) {
      ref.read(assistantLanguagePreferenceProvider.notifier).select(chosen);
    }
  }

  Future<void> _confirmClear(AssistantStrings strings) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(strings.clearConversationConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(strings.cancel)),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(strings.clearConversation),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      ref.read(assistantConversationProvider.notifier).clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(assistantLanguagePreferenceProvider) ?? AssistantLanguage.english;
    final strings = AssistantStrings.of(language);
    final conversation = ref.watch(assistantConversationProvider);

    ref.listen(assistantConversationProvider, (previous, next) {
      if (next.messages.length != (previous?.messages.length ?? 0)) _scrollToBottom();
    });

    final theme = Theme.of(context);

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(
            title: strings.title,
            changeLanguageTooltip: strings.changeLanguageTooltip,
            clearConversationTooltip: strings.clearConversation,
            minimizeTooltip: strings.minimizeTooltip,
            onChangeLanguage: () => _changeLanguage(language),
            onClear: conversation.messages.isEmpty ? null : () => _confirmClear(strings),
            onMinimize: widget.onMinimize,
          ),
          const Divider(height: 1),
          Expanded(
            child: conversation.messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 36,
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            strings.emptyConversation,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: conversation.messages.length + (conversation.isSending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == conversation.messages.length) {
                        return const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            child: TypingIndicator(),
                          ),
                        );
                      }
                      final message = conversation.messages[index];
                      return ChatMessageBubble(message: message, language: language);
                    },
                  ),
          ),
          const Divider(height: 1),
          _InputBar(
            controller: _inputController,
            hint: strings.inputHint,
            enabled: !conversation.isSending,
            onSend: _send,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.changeLanguageTooltip,
    required this.clearConversationTooltip,
    required this.minimizeTooltip,
    required this.onChangeLanguage,
    required this.onClear,
    required this.onMinimize,
  });

  final String title;
  final String changeLanguageTooltip;
  final String clearConversationTooltip;
  final String minimizeTooltip;
  final VoidCallback onChangeLanguage;
  final VoidCallback? onClear;
  final VoidCallback onMinimize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(Icons.smart_toy_outlined, color: theme.colorScheme.onPrimaryContainer),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            tooltip: changeLanguageTooltip,
            icon: const Icon(Icons.language),
            color: theme.colorScheme.onPrimaryContainer,
            onPressed: onChangeLanguage,
          ),
          IconButton(
            tooltip: clearConversationTooltip,
            icon: const Icon(Icons.delete_outline),
            color: theme.colorScheme.onPrimaryContainer,
            onPressed: onClear,
          ),
          IconButton(
            tooltip: minimizeTooltip,
            icon: const Icon(Icons.remove),
            color: theme.colorScheme.onPrimaryContainer,
            onPressed: onMinimize,
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.hint,
    required this.enabled,
    required this.onSend,
  });

  final TextEditingController controller;
  final String hint;
  final bool enabled;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              decoration: InputDecoration(hintText: hint, isDense: true),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => enabled ? onSend() : null,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton.filled(
            icon: const Icon(Icons.send),
            onPressed: enabled ? onSend : null,
          ),
        ],
      ),
    );
  }
}
