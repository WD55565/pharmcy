import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/assistant/data/datasources/assistant_language_local_data_source.dart';
import 'package:mobile/features/assistant/data/repositories/gemini_assistant_repository_impl.dart';
import 'package:mobile/features/assistant/domain/entities/assistant_language.dart';
import 'package:mobile/features/assistant/domain/entities/chat_message.dart';
import 'package:mobile/features/assistant/domain/repositories/assistant_repository.dart';
import 'package:mobile/features/assistant/presentation/providers/assistant_conversation_provider.dart';

import '../../../../support/fake_local_data_sources.dart';

/// Returns replies instantly (no artificial delay) and echoes the question
/// back, so tests can assert on exact content without waiting on the mock
/// repository's simulated "thinking" delay.
class _InstantEchoRepository implements AssistantRepository {
  int callCount = 0;

  @override
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
    required AssistantLanguage language,
  }) async {
    callCount++;
    return ChatMessage(
      id: 'reply-$callCount',
      role: ChatMessageRole.assistant,
      content: 'echo: $userMessage',
      sentAt: DateTime.now(),
    );
  }
}

/// Never resolves within a test's lifetime — used to test the
/// one-question-at-a-time / isSending behaviour deterministically without
/// racing a real delay.
class _ControllableRepository implements AssistantRepository {
  @override
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
    required AssistantLanguage language,
  }) {
    return Completer<ChatMessage>().future;
  }
}

ProviderContainer _makeContainer(AssistantRepository repository) {
  final container = ProviderContainer(
    overrides: [
      assistantRepositoryProvider.overrideWithValue(repository),
      assistantLanguageLocalDataSourceProvider.overrideWithValue(
        FakeAssistantLanguageLocalDataSource(initial: AssistantLanguage.english),
      ),
    ],
  );
  addTearDown(container.dispose);
  // assistantConversationProvider is autoDispose (as it should be in the
  // real app — no reason to keep chat state alive with zero listeners);
  // keep it alive for the duration of the test with a no-op listener so
  // container.read() doesn't recreate a fresh instance between calls.
  container.listen(assistantConversationProvider, (previous, next) {});
  return container;
}

void main() {
  group('AssistantConversation', () {
    test('starts with an empty conversation', () {
      final container = _makeContainer(_InstantEchoRepository());
      final state = container.read(assistantConversationProvider);

      expect(state.messages, isEmpty);
      expect(state.isSending, isFalse);
    });

    test('sendMessage appends the user message then the assistant reply', () async {
      final container = _makeContainer(_InstantEchoRepository());

      await container.read(assistantConversationProvider.notifier).sendMessage('hello');

      final state = container.read(assistantConversationProvider);
      expect(state.messages, hasLength(2));
      expect(state.messages[0].role, ChatMessageRole.user);
      expect(state.messages[0].content, 'hello');
      expect(state.messages[1].role, ChatMessageRole.assistant);
      expect(state.messages[1].content, 'echo: hello');
      expect(state.isSending, isFalse);
    });

    test('ignores a blank message', () async {
      final container = _makeContainer(_InstantEchoRepository());

      await container.read(assistantConversationProvider.notifier).sendMessage('   ');

      expect(container.read(assistantConversationProvider).messages, isEmpty);
    });

    test('trims whitespace from the user message', () async {
      final container = _makeContainer(_InstantEchoRepository());

      await container.read(assistantConversationProvider.notifier).sendMessage('  hello  ');

      expect(container.read(assistantConversationProvider).messages.first.content, 'hello');
    });

    test('clear() empties the conversation', () async {
      final container = _makeContainer(_InstantEchoRepository());
      await container.read(assistantConversationProvider.notifier).sendMessage('hello');
      expect(container.read(assistantConversationProvider).messages, isNotEmpty);

      container.read(assistantConversationProvider.notifier).clear();

      final state = container.read(assistantConversationProvider);
      expect(state.messages, isEmpty);
      expect(state.isSending, isFalse);
    });

    test('a second sendMessage while one is in flight is ignored (one question at a time)', () async {
      final repository = _ControllableRepository();
      final container = _makeContainer(repository);
      final notifier = container.read(assistantConversationProvider.notifier);

      // Don't await — this leaves isSending true, simulating an in-flight
      // request (the repository above never resolves).
      final firstSend = notifier.sendMessage('first question');
      // Let the state update to isSending: true propagate.
      await Future<void>.delayed(Duration.zero);

      expect(container.read(assistantConversationProvider).isSending, isTrue);

      await notifier.sendMessage('second question, should be ignored');

      final state = container.read(assistantConversationProvider);
      expect(state.messages, hasLength(1));
      expect(state.messages.single.content, 'first question');

      // Not awaiting firstSend to completion is fine here — it's backed by
      // a Future that deliberately never resolves within the test.
      unawaited(firstSend);
    });
  });
}
