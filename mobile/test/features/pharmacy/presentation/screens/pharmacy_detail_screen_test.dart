import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart' show Override;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/core/localization/l10n/app_localizations.dart';
import 'package:mobile/core/network/failure.dart';
import 'package:mobile/features/pharmacy/data/datasources/pharmacy_favorites_local_data_source.dart';
import 'package:mobile/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:mobile/features/pharmacy/presentation/providers/pharmacy_detail_provider.dart';
import 'package:mobile/features/pharmacy/presentation/screens/pharmacy_detail_screen.dart';
import 'package:mobile/features/pharmacy/presentation/widgets/pharmacy_detail_skeleton.dart';
import 'package:mobile/features/pharmacy/presentation/widgets/pharmacy_map_preview.dart';

/// In-memory stand-in for the real SharedPreferences-backed data source, so
/// tests never touch actual device storage.
class _FakeFavoritesLocalDataSource extends PharmacyFavoritesLocalDataSource {
  _FakeFavoritesLocalDataSource() : super(_UnusedPrefs());

  Set<int> _stored = {};

  @override
  Set<int> loadFavoriteIds() => _stored;

  @override
  Future<void> saveFavoriteIds(Set<int> ids) async => _stored = ids;
}

// Never actually called — loadFavoriteIds/saveFavoriteIds are overridden
// above to avoid touching real SharedPreferences in tests.
class _UnusedPrefs implements SharedPreferences {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('SharedPreferences should not be used directly in tests');
}

const _pharmacy = Pharmacy(
  id: 42,
  name: 'Merkez Eczanesi',
  phone: '0212 555 55 55',
  address: 'Bağdat Cad. No:10',
  district: 'Kadıköy',
  latitude: 40.99,
  longitude: 29.03,
  isOnDuty: true,
  openingTime: '09:00:00',
  closingTime: '19:30:00',
);

const _pharmacyWithoutCoordinates = Pharmacy(
  id: 43,
  name: 'Sahil Eczanesi',
  phone: '0212 222 22 22',
  address: 'Barbaros Bulvarı No:5',
  district: 'Beşiktaş',
  latitude: 0,
  longitude: 0,
  isOnDuty: false,
);

/// Resolves instantly with a fixed [Pharmacy], so the screen can be tested
/// without a live backend (Flutter's test binding fakes all real HTTP calls
/// as 400 responses regardless, so hitting the network here isn't an
/// option).
class _FakePharmacyDetail extends PharmacyDetail {
  @override
  Future<Pharmacy> build(int id) async => _pharmacy;
}

class _FakePharmacyDetailWithoutCoordinates extends PharmacyDetail {
  @override
  Future<Pharmacy> build(int id) async => _pharmacyWithoutCoordinates;
}

/// Fails every time, to exercise the error state without a real network call.
class _FailingPharmacyDetail extends PharmacyDetail {
  @override
  Future<Pharmacy> build(int id) async {
    throw const Failure.unknown('boom');
  }
}

Widget _wrap(Widget child, {required List<Override> overrides}) {
  return ProviderScope(
    overrides: [
      pharmacyFavoritesLocalDataSourceProvider.overrideWithValue(
        _FakeFavoritesLocalDataSource(),
      ),
      ...overrides,
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

void main() {
  testWidgets('renders every required pharmacy field', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const PharmacyDetailScreen(pharmacyId: 42),
        overrides: [
          pharmacyDetailProvider(42).overrideWith(_FakePharmacyDetail.new),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(_pharmacy.name), findsWidgets);
    expect(find.text(_pharmacy.address), findsOneWidget);
    expect(find.text(_pharmacy.district), findsOneWidget);
    expect(find.text(_pharmacy.phone), findsOneWidget);
    expect(find.textContaining('09:00'), findsOneWidget);
    expect(find.textContaining('19:30'), findsOneWidget);

    expect(find.byIcon(Icons.call_outlined), findsOneWidget);
    // One for the district row, one for the "Open in Maps" button.
    expect(find.byIcon(Icons.map_outlined), findsNWidgets(2));
    expect(find.byIcon(Icons.share_outlined), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping the favorite icon toggles it to filled', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const PharmacyDetailScreen(pharmacyId: 42),
        overrides: [
          pharmacyDetailProvider(42).overrideWith(_FakePharmacyDetail.new),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows a skeleton loading state before data arrives', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const PharmacyDetailScreen(pharmacyId: 42),
        overrides: [
          pharmacyDetailProvider(42).overrideWith(_FakePharmacyDetail.new),
        ],
      ),
    );

    // Before the fake future resolves, the skeleton loading state must be
    // visible instead of the real content.
    expect(find.byType(PharmacyDetailSkeleton), findsOneWidget);
    expect(find.text(_pharmacy.address), findsNothing);

    await tester.pumpAndSettle();

    expect(find.byType(PharmacyDetailSkeleton), findsNothing);
  });

  testWidgets('shows an error state with retry when loading fails', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const PharmacyDetailScreen(pharmacyId: 42),
        overrides: [
          pharmacyDetailProvider(42).overrideWith(_FailingPharmacyDetail.new),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Retry'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows a map preview when the pharmacy has coordinates', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const PharmacyDetailScreen(pharmacyId: 42),
        overrides: [
          pharmacyDetailProvider(42).overrideWith(_FakePharmacyDetail.new),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(GoogleMap), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('hides the map preview gracefully when coordinates are missing', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const PharmacyDetailScreen(pharmacyId: 43),
        overrides: [
          pharmacyDetailProvider(
            43,
          ).overrideWith(_FakePharmacyDetailWithoutCoordinates.new),
        ],
      ),
    );
    await tester.pumpAndSettle();

    // The screen still renders normally — no map, no crash, and the "Open
    // in Maps" button still falls back to an address-based search.
    expect(find.byType(GoogleMap), findsNothing);
    expect(find.text(_pharmacyWithoutCoordinates.name), findsWidgets);
    expect(find.widgetWithText(OutlinedButton, 'Show on Map'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping the map preview also opens the maps action', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const PharmacyDetailScreen(pharmacyId: 42),
        overrides: [
          pharmacyDetailProvider(42).overrideWith(_FakePharmacyDetail.new),
        ],
      ),
    );
    await tester.pumpAndSettle();

    // Tapping the preview attempts to launch the maps app just like the
    // button; in the test sandbox url_launcher can't actually open
    // anything, so this only needs to resolve without throwing. The map
    // itself is wrapped in an AbsorbPointer, so the tap target is the
    // preview widget, not GoogleMap's own render object.
    await tester.tap(find.byType(PharmacyMapPreview));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
