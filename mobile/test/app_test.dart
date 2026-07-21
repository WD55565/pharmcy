import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/features/assistant/data/datasources/assistant_language_local_data_source.dart';
import 'package:mobile/features/pharmacy/data/datasources/pharmacy_favorites_local_data_source.dart';

import 'support/fake_local_data_sources.dart';

void main() {
  testWidgets('app boots and renders the home screen shell', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(
              flavor: AppFlavor.development,
              // Deliberately unreachable in the test sandbox — this proves
              // the screen doesn't crash and instead settles into an error
              // state driven by AsyncValue, not a real backend.
              apiBaseUrl: 'http://localhost:8080/api',
            ),
          ),
          pharmacyFavoritesLocalDataSourceProvider.overrideWithValue(
            FakeFavoritesLocalDataSource(),
          ),
          assistantLanguageLocalDataSourceProvider.overrideWithValue(
            FakeAssistantLanguageLocalDataSource(),
          ),
        ],
        child: const NobetciEczaneApp(),
      ),
    );
    await tester.pumpAndSettle();

    // App shell is present regardless of the network outcome.
    expect(find.byType(Scaffold), findsWidgets);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);

    // No uncaught exceptions from the failed request; it settled into a
    // handled state instead.
    expect(tester.takeException(), isNull);
  });
}
