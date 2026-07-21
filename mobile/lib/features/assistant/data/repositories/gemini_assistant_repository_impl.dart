import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/assistant_language.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/assistant_repository.dart';
import '../datasources/assistant_remote_data_source.dart';

part 'gemini_assistant_repository_impl.g.dart';

/// Real [AssistantRepository] backed by the app's own backend, which in
/// turn calls Google's Gemini API server-side (see
/// `AssistantController`/`AssistantServiceImpl` in `backend/`). The
/// pharmacy-intent detection and database lookup also happen server-side,
/// so this class is a thin, provider-agnostic HTTP client — swapping
/// Gemini for a different AI provider later only touches the backend, not
/// this class or anything in `presentation/`.
class GeminiAssistantRepositoryImpl implements AssistantRepository {
  GeminiAssistantRepositoryImpl(this._remoteDataSource);

  final AssistantRemoteDataSource _remoteDataSource;

  @override
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
    required AssistantLanguage language,
  }) async {
    final historyPayload = history
        .map(
          (message) => {
            'role': message.role == ChatMessageRole.user ? 'user' : 'assistant',
            'content': message.content,
          },
        )
        .toList();

    final reply = await _remoteDataSource.chat(
      message: userMessage,
      history: historyPayload,
      language: _languageLabel(language),
    );

    return ChatMessage(
      id: 'assistant-${DateTime.now().microsecondsSinceEpoch}',
      role: ChatMessageRole.assistant,
      content: reply,
      sentAt: DateTime.now(),
    );
  }

  /// The backend/Gemini system prompt reads this as plain English text
  /// (e.g. "the app's currently selected language is Turkish"), not a
  /// locale code — Gemini itself still auto-detects and prioritizes
  /// whatever language the user actually typed in.
  String _languageLabel(AssistantLanguage language) => switch (language) {
    AssistantLanguage.english => 'English',
    AssistantLanguage.turkish => 'Turkish',
    AssistantLanguage.arabic => 'Arabic',
  };
}

@riverpod
AssistantRepository assistantRepository(Ref ref) {
  return GeminiAssistantRepositoryImpl(ref.watch(assistantRemoteDataSourceProvider));
}
