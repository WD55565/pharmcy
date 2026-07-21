import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/localization/l10n/app_localizations.dart';
import 'package:mobile/features/assistant/data/datasources/assistant_language_local_data_source.dart';
import 'package:mobile/features/assistant/data/repositories/gemini_assistant_repository_impl.dart';
import 'package:mobile/features/assistant/domain/entities/assistant_language.dart';
import 'package:mobile/features/assistant/domain/entities/chat_message.dart';
import 'package:mobile/features/assistant/domain/repositories/assistant_repository.dart';
import 'package:mobile/features/assistant/presentation/widgets/assistant_launcher.dart';
import 'package:mobile/features/pharmacy/data/repositories/pharmacy_repository_impl.dart' show pharmacyRepositoryProvider;
import 'package:mobile/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:mobile/core/network/result.dart';
import 'package:mobile/features/pharmacy/domain/repositories/pharmacy_repository.dart';

import '../../../../support/fake_local_data_sources.dart';

class _InstantRepository implements AssistantRepository {
  @override
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
    required AssistantLanguage language,
  }) async {
    return ChatMessage(
      id: 'reply',
      role: ChatMessageRole.assistant,
      content: 'reply to: $userMessage',
      sentAt: DateTime.now(),
    );
  }
}

class _FakePharmacyRepository implements PharmacyRepository {
  @override
  Future<Result<List<Pharmacy>>> getPharmacies() async => const Result.success([]);

  @override
  Future<Result<Pharmacy>> getPharmacyById(int id) async {
    throw UnimplementedError();
  }
}

Future<void> _pumpLauncher(
  WidgetTester tester, {
  AssistantLanguage? initialLanguage,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        assistantRepositoryProvider.overrideWithValue(_InstantRepository()),
        pharmacyRepositoryProvider.overrideWithValue(_FakePharmacyRepository()),
        assistantLanguageLocalDataSourceProvider.overrideWithValue(
          FakeAssistantLanguageLocalDataSource(initial: initialLanguage),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: Stack(children: [AssistantLauncher()])),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows a floating action button by default', (tester) async {
    await _pumpLauncher(tester, initialLanguage: AssistantLanguage.english);

    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('first open with no saved language shows the language picker', (tester) async {
    await _pumpLauncher(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Choose a language'), findsOneWidget);
    expect(find.text('العربية'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Türkçe'), findsOneWidget);
  });

  testWidgets('choosing a language opens the chat panel and is remembered', (tester) async {
    await _pumpLauncher(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Chat panel is now open — its header title should be visible, and the
    // FAB should be gone (replaced by the panel).
    expect(find.text('Pharmacy Assistant'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets('opening again with a saved language skips the picker', (tester) async {
    await _pumpLauncher(tester, initialLanguage: AssistantLanguage.turkish);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Choose a language'), findsNothing);
    expect(find.text('Eczane Asistanı'), findsOneWidget);
  });

  testWidgets('minimize button collapses the panel back to the FAB', (tester) async {
    await _pumpLauncher(tester, initialLanguage: AssistantLanguage.english);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Pharmacy Assistant'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Pharmacy Assistant'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
