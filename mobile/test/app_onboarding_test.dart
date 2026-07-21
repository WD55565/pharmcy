import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/features/assistant/data/datasources/assistant_language_local_data_source.dart';
import 'package:mobile/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:mobile/features/pharmacy/data/datasources/pharmacy_favorites_local_data_source.dart';

import 'support/fake_local_data_sources.dart';

void main() {
  testWidgets('first visit shows the onboarding flow, then reaches home after Continue', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(
              flavor: AppFlavor.development,
              apiBaseUrl: 'http://localhost:8080/api',
            ),
          ),
          pharmacyFavoritesLocalDataSourceProvider.overrideWithValue(FakeFavoritesLocalDataSource()),
          assistantLanguageLocalDataSourceProvider.overrideWithValue(
            FakeAssistantLanguageLocalDataSource(),
          ),
          onboardingLocalDataSourceProvider.overrideWithValue(
            FakeOnboardingLocalDataSource(completed: false),
          ),
        ],
        child: const NobetciEczaneApp(),
      ),
    );

    // Splash is showing first.
    await tester.pump();
    expect(find.text('Nöbetçi Eczane+'), findsOneWidget);

    // Let the splash animation (2200ms controller + 350ms hand-off delay)
    // run to completion, in staged steps so both the AnimationController
    // and the subsequent Future.delayed actually fire.
    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Choose your language'), findsOneWidget);
    expect(tester.takeException(), isNull);

    // Pick English.
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Welcome step.
    expect(find.text('Welcome to Nöbetçi Eczane+'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Home screen shell is now showing.
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
