import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/gemini_assistant_repository_impl.dart';
import '../../domain/entities/assistant_language.dart';
import '../../domain/entities/chat_message.dart';
import '../widgets/assistant_strings.dart';
import 'assistant_language_provider.dart';

part 'assistant_conversation_provider.g.dart';

/// [messages] is the full conversation so far (oldest first); [isSending]
/// is true while a reply is pending — used both to show the typing
/// indicator and to enforce answering one question at a time.
typedef AssistantConversationState = ({List<ChatMessage> messages, bool isSending});

@riverpod
class AssistantConversation extends _$AssistantConversation {
  @override
  AssistantConversationState build() => (messages: const [], isSending: false);

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isSending) return;

    final history = state.messages;
    final userMessage = ChatMessage(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      role: ChatMessageRole.user,
      content: trimmed,
      sentAt: DateTime.now(),
    );
    state = (messages: [...history, userMessage], isSending: true);

    final language = ref.read(assistantLanguagePreferenceProvider) ?? AssistantLanguage.english;

    try {
      final reply = await ref
          .read(assistantRepositoryProvider)
          .sendMessage(userMessage: trimmed, history: history, language: language);
      state = (messages: [...state.messages, reply], isSending: false);
    } catch (_) {
      // Network failure, backend down, AI provider misconfigured/unavailable,
      // etc. — surface it as a normal (if apologetic) assistant message
      // rather than silently leaving the conversation stuck or the UI
      // unchanged, so the user always gets a visible response to their
      // question.
      final errorMessage = ChatMessage(
        id: 'assistant-error-${DateTime.now().microsecondsSinceEpoch}',
        role: ChatMessageRole.assistant,
        content: AssistantStrings.of(language).serviceUnavailable,
        sentAt: DateTime.now(),
      );
      state = (messages: [...state.messages, errorMessage], isSending: false);
    }
  }

  void clear() => state = (messages: const [], isSending: false);
}
