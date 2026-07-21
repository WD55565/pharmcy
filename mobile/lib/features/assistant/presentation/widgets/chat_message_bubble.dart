import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../domain/entities/assistant_language.dart';
import '../../domain/entities/chat_message.dart';

/// A single chat bubble: right-aligned/accent for the user, left-aligned
/// for the assistant, with the assistant's content rendered as markdown.
/// Wrapped in [Directionality] matching [language] so Arabic replies flow
/// right-to-left regardless of the app's own UI direction.
class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({required this.message, required this.language, super.key});

  final ChatMessage message;
  final AssistantLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.role == ChatMessageRole.user;
    final colorScheme = theme.colorScheme;

    final bubbleColor = isUser ? colorScheme.primary : colorScheme.surfaceContainerHigh;
    final textColor = isUser ? colorScheme.onPrimary : colorScheme.onSurface;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: Directionality(
          textDirection: language.isRightToLeft ? TextDirection.rtl : TextDirection.ltr,
          child: isUser
              ? Text(message.content, style: TextStyle(color: textColor))
              : MarkdownBody(
                  data: message.content,
                  styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                    p: TextStyle(color: textColor),
                    strong: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                    listBullet: TextStyle(color: textColor),
                  ),
                ),
        ),
      ),
    );
  }
}
