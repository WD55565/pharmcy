import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/localization/l10n/app_localizations.dart';
import 'package:mobile/features/home/presentation/screens/home_screen.dart';
import 'package:mobile/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:mobile/features/pharmacy/presentation/providers/pharmacy_list_provider.dart';

const _kadikoyOnDuty = Pharmacy(
  id: 1,
  name: 'Merkez Eczanesi',
  phone: '0212 111 11 11',
  address: 'Bağdat Caddesi No:1',
  district: 'Kadıköy',
  latitude: 40.99,
  longitude: 29.03,
  isOnDuty: true,
);

const _besiktasOffDuty = Pharmacy(
  id: 2,
  name: 'Sahil Eczanesi',
  phone: '0212 222 22 22',
  address: 'Barbaros Bulvarı No:5',
  district: 'Beşiktaş',
  latitude: 41.04,
  longitude: 29.00,
  isOnDuty: false,
);

/// Resolves instantly with a fixed list, so these are pure widget tests of
/// the search/filter UI — no network call is ever made.
class _FakePharmacyList extends PharmacyList {
  @override
  Future<List<Pharmacy>> build() async => [_kadikoyOnDuty, _besiktasOffDuty];
}

Future<void> _pumpHome(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [pharmacyListProvider.overrideWith(_FakePharmacyList.new)],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows every pharmacy with no filters applied', (tester) async {
    await _pumpHome(tester);

    expect(find.text('Merkez Eczanesi'), findsOneWidget);
    expect(find.text('Sahil Eczanesi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'typing a district name filters (after debounce), with no extra network call',
    (tester) async {
      await _pumpHome(tester);

      await tester.enterText(find.byType(TextField), 'beşiktaş');
      // Search updates are debounced by 300ms to avoid re-filtering on
      // every keystroke; advance the (fake) clock past that.
      await tester.pump(const Duration(milliseconds: 350));

      expect(find.text('Sahil Eczanesi'), findsOneWidget);
      expect(find.text('Merkez Eczanesi'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('typing an address substring filters (after debounce)', (tester) async {
    await _pumpHome(tester);

    await tester.enterText(find.byType(TextField), 'bağdat');
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Merkez Eczanesi'), findsOneWidget);
    expect(find.text('Sahil Eczanesi'), findsNothing);
  });

  testWidgets('selecting a district chip filters the list', (tester) async {
    await _pumpHome(tester);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Kadıköy'));
    await tester.pumpAndSettle();

    expect(find.text('Merkez Eczanesi'), findsOneWidget);
    expect(find.text('Sahil Eczanesi'), findsNothing);
  });

  testWidgets('toggling On Duty Only excludes pharmacies not on duty', (
    tester,
  ) async {
    await _pumpHome(tester);

    await tester.tap(find.widgetWithText(FilterChip, 'On Duty Only'));
    await tester.pumpAndSettle();

    expect(find.text('Merkez Eczanesi'), findsOneWidget);
    expect(find.text('Sahil Eczanesi'), findsNothing);
  });

  testWidgets(
    'Clear Filters appears only when a filter is active, and resets the list',
    (tester) async {
      await _pumpHome(tester);

      expect(find.widgetWithText(TextButton, 'Clear Filters'), findsNothing);

      await tester.tap(find.widgetWithText(FilterChip, 'On Duty Only'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(TextButton, 'Clear Filters'), findsOneWidget);
      expect(find.text('Sahil Eczanesi'), findsNothing);

      await tester.tap(find.widgetWithText(TextButton, 'Clear Filters'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextButton, 'Clear Filters'), findsNothing);
      expect(find.text('Merkez Eczanesi'), findsOneWidget);
      expect(find.text('Sahil Eczanesi'), findsOneWidget);
    },
  );

  testWidgets(
    'shows empty state with a Clear Filters action when nothing matches',
    (tester) async {
      await _pumpHome(tester);

      await tester.enterText(find.byType(TextField), 'no such pharmacy exists');
      await tester.pumpAndSettle();

      expect(find.textContaining('No pharmacies found'), findsOneWidget);
      expect(
        find.widgetWithText(OutlinedButton, 'Clear Filters'),
        findsOneWidget,
      );
      expect(find.text('Merkez Eczanesi'), findsNothing);
      expect(find.text('Sahil Eczanesi'), findsNothing);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Clear Filters'));
      await tester.pumpAndSettle();

      expect(find.text('Merkez Eczanesi'), findsOneWidget);
      expect(find.text('Sahil Eczanesi'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('search and district filters combine', (tester) async {
    await _pumpHome(tester);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Beşiktaş'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'merkez');
    await tester.pumpAndSettle();

    // "merkez" only matches the Kadıköy pharmacy, but the district filter is
    // pinned to Beşiktaş, so nothing should match either pharmacy.
    expect(find.text('Merkez Eczanesi'), findsNothing);
    expect(find.text('Sahil Eczanesi'), findsNothing);
    expect(find.textContaining('No pharmacies found'), findsOneWidget);
  });
}
