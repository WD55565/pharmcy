import '../entities/assistant_language.dart';
import '../entities/chat_message.dart';

/// Contract the presentation layer depends on for getting an assistant
/// reply. Today implemented by [MockAssistantRepositoryImpl] (canned
/// responses, some backed by real pharmacy data); a future real AI/LLM
/// backend only means adding a new implementation of this interface and
/// swapping the Riverpod provider override — nothing in
/// `presentation/` needs to change.
abstract interface class AssistantRepository {
  /// Returns the assistant's reply to [userMessage]. [history] is the
  /// conversation so far (oldest first, not including [userMessage]) so an
  /// implementation can use it for context; the mock implementation
  /// ignores it today. [language] selects which language to reply in.
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
    required AssistantLanguage language,
  });
}
