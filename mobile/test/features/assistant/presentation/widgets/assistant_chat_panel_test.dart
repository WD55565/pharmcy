import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/localization/l10n/app_localizations.dart';
import 'package:mobile/features/assistant/data/datasources/assistant_language_local_data_source.dart';
import 'package:mobile/features/assistant/data/repositories/mock_assistant_repository_impl.dart';
import 'package:mobile/features/assistant/domain/entities/assistant_language.dart';
import 'package:mobile/features/assistant/domain/entities/chat_message.dart';
import 'package:mobile/features/assistant/domain/repositories/assistant_repository.dart';
import 'package:mobile/features/assistant/presentation/widgets/assistant_chat_panel.dart';
import 'package:mobile/features/assistant/presentation/widgets/typing_indicator.dart';

import '../../../../support/fake_local_data_sources.dart';

/// Replies after a short controllable delay, so tests can observe the
/// typing indicator before the reply lands.
class _DelayedRepository implements AssistantRepository {
  _DelayedRepository({this.delay = const Duration(milliseconds: 50)});

  final Duration delay;

  @override
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
    required AssistantLanguage language,
  }) async {
    await Future<void>.delayed(delay);
    return ChatMessage(
      id: 'reply-${DateTime.now().microsecondsSinceEpoch}',
      role: ChatMessageRole.assistant,
      content: 'reply to: $userMessage',
      sentAt: DateTime.now(),
    );
  }
}

Future<void> _pumpPanel(WidgetTester tester, {AssistantRepository? repository}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        assistantRepositoryProvider.overrideWithValue(repository ?? _DelayedRepository()),
        assistantLanguageLocalDataSourceProvider.overrideWithValue(
          FakeAssistantLanguageLocalDataSource(initial: AssistantLanguage.english),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SizedBox(
            width: 360,
            height: 520,
            child: AssistantChatPanel(onMinimize: () {}),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the empty-conversation hint with no messages', (tester) async {
    await _pumpPanel(tester);

    expect(find.textContaining('Ask me about'), findsOneWidget);
  });

  testWidgets('sending a message shows it, then a typing indicator, then the reply', (
    tester,
  ) async {
    await _pumpPanel(tester);

    await tester.enterText(find.byType(TextField), 'which pharmacies are on duty?');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // User message appears immediately.
    expect(find.text('which pharmacies are on duty?'), findsOneWidget);
    // Reply hasn't arrived yet — typing indicator shows instead.
    expect(find.byType(TypingIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(TypingIndicator), findsNothing);
    expect(find.textContaining('reply to: which pharmacies are on duty?'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the input is disabled while a reply is pending (one question at a time)', (
    tester,
  ) async {
    await _pumpPanel(tester, repository: _DelayedRepository(delay: const Duration(seconds: 5)));

    await tester.enterText(find.byType(TextField), 'first question');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.enabled, isFalse);

    // Let the pending future resolve so no Timer/Future leaks past the
    // test.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('clear conversation button removes all messages after confirmation', (
    tester,
  ) async {
    await _pumpPanel(tester, repository: _DelayedRepository(delay: Duration.zero));

    await tester.enterText(find.byType(TextField), 'hello');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();
    expect(find.text('hello'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    // Confirmation dialog.
    expect(find.text('Clear conversation'), findsWidgets);
    await tester.tap(find.text('Clear conversation').last);
    await tester.pumpAndSettle();

    expect(find.text('hello'), findsNothing);
    expect(find.textContaining('Ask me about'), findsOneWidget);
  });

  testWidgets('clear conversation button is disabled when there is nothing to clear', (
    tester,
  ) async {
    await _pumpPanel(tester);

    final clearButton = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.delete_outline),
    );
    expect(clearButton.onPressed, isNull);
  });
}
