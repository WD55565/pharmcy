import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/assistant/data/datasources/assistant_remote_data_source.dart';
import 'package:mobile/features/assistant/data/repositories/gemini_assistant_repository_impl.dart';
import 'package:mobile/features/assistant/domain/entities/assistant_language.dart';
import 'package:mobile/features/assistant/domain/entities/chat_message.dart';

/// Captures exactly what would be sent over HTTP, without a real Dio call
/// (the `chat` override below never touches the underlying Dio instance).
class _CapturingRemoteDataSource extends AssistantRemoteDataSource {
  _CapturingRemoteDataSource() : super(Dio());

  String? capturedMessage;
  List<Map<String, String>>? capturedHistory;
  String? capturedLanguage;
  String replyToReturn = 'a reply';

  @override
  Future<String> chat({
    required String message,
    required List<Map<String, String>> history,
    required String language,
  }) async {
    capturedMessage = message;
    capturedHistory = history;
    capturedLanguage = language;
    return replyToReturn;
  }
}

void main() {
  group('GeminiAssistantRepositoryImpl', () {
    test('forwards the message and returns an assistant ChatMessage', () async {
      final dataSource = _CapturingRemoteDataSource()..replyToReturn = 'Hello there!';
      final repository = GeminiAssistantRepositoryImpl(dataSource);

      final result = await repository.sendMessage(
        userMessage: 'hi',
        history: const [],
        language: AssistantLanguage.english,
      );

      expect(result.role, ChatMessageRole.assistant);
      expect(result.content, 'Hello there!');
      expect(dataSource.capturedMessage, 'hi');
    });

    test('maps the selected language to its English label', () async {
      final dataSource = _CapturingRemoteDataSource();
      final repository = GeminiAssistantRepositoryImpl(dataSource);

      await repository.sendMessage(userMessage: 'hi', history: const [], language: AssistantLanguage.turkish);
      expect(dataSource.capturedLanguage, 'Turkish');

      await repository.sendMessage(userMessage: 'hi', history: const [], language: AssistantLanguage.arabic);
      expect(dataSource.capturedLanguage, 'Arabic');

      await repository.sendMessage(userMessage: 'hi', history: const [], language: AssistantLanguage.english);
      expect(dataSource.capturedLanguage, 'English');
    });

    test('converts conversation history into role/content maps', () async {
      final dataSource = _CapturingRemoteDataSource();
      final repository = GeminiAssistantRepositoryImpl(dataSource);
      final history = [
        ChatMessage(id: '1', role: ChatMessageRole.user, content: 'hi', sentAt: DateTime.now()),
        ChatMessage(id: '2', role: ChatMessageRole.assistant, content: 'hello!', sentAt: DateTime.now()),
      ];

      await repository.sendMessage(userMessage: 'follow up', history: history, language: AssistantLanguage.english);

      expect(dataSource.capturedHistory, [
        {'role': 'user', 'content': 'hi'},
        {'role': 'assistant', 'content': 'hello!'},
      ]);
    });
  });
}
