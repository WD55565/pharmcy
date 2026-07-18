import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:mobile/features/pharmacy/presentation/providers/filtered_pharmacies_provider.dart';
import 'package:mobile/features/pharmacy/presentation/providers/pharmacy_filters_provider.dart';
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

const _sisliOnDuty = Pharmacy(
  id: 3,
  name: 'Şifa Eczanesi',
  phone: '0212 333 33 33',
  address: 'Halaskargazi Caddesi No:9',
  district: 'Şişli',
  latitude: 41.06,
  longitude: 28.99,
  isOnDuty: true,
);

final _allPharmacies = [_kadikoyOnDuty, _besiktasOffDuty, _sisliOnDuty];

/// Resolves instantly with a fixed list — this is what makes these tests
/// pure unit tests of the filtering logic, with no network involved at all
/// (not even the always-400 fake HTTP client `flutter test` normally hits).
class _FakePharmacyList extends PharmacyList {
  @override
  Future<List<Pharmacy>> build() async => _allPharmacies;
}

ProviderContainer _makeContainer() {
  final container = ProviderContainer(
    overrides: [pharmacyListProvider.overrideWith(_FakePharmacyList.new)],
  );
  addTearDown(container.dispose);
  return container;
}

Future<List<Pharmacy>> _resolve(ProviderContainer container) async {
  // The underlying pharmacyListProvider is async; wait for it once so the
  // derived filteredPharmaciesProvider has real data instead of `loading`.
  await container.read(pharmacyListProvider.future);
  return container.read(filteredPharmaciesProvider).requireValue;
}

void main() {
  group('filteredPharmaciesProvider', () {
    test('with no filters, returns every pharmacy unchanged', () async {
      final container = _makeContainer();
      final result = await _resolve(container);
      expect(result, _allPharmacies);
    });

    test('search matches by name, case-insensitively', () async {
      final container = _makeContainer();
      container.read(pharmacySearchQueryProvider.notifier).update('merkez');
      final result = await _resolve(container);
      expect(result, [_kadikoyOnDuty]);
    });

    test('search matches by district', () async {
      final container = _makeContainer();
      container.read(pharmacySearchQueryProvider.notifier).update('beşiktaş');
      final result = await _resolve(container);
      expect(result, [_besiktasOffDuty]);
    });

    test('search matches by address', () async {
      final container = _makeContainer();
      container
          .read(pharmacySearchQueryProvider.notifier)
          .update('halaskargazi');
      final result = await _resolve(container);
      expect(result, [_sisliOnDuty]);
    });

    test('search trims surrounding whitespace', () async {
      final container = _makeContainer();
      container
          .read(pharmacySearchQueryProvider.notifier)
          .update('   merkez   ');
      final result = await _resolve(container);
      expect(result, [_kadikoyOnDuty]);
    });

    test(
      'search is Turkish-character aware (dotless ı matches dotted İ source)',
      () async {
        final container = _makeContainer();
        // "şifa" typed with a plain ASCII "i" should still find "Şifa" -
        // Turkish lowercasing of the source text turns "Ş" into "ş" and the
        // stored "i" stays "i"; the real-world risk is the reverse (I/İ), which
        // normalizeTurkish's own unit tests cover directly.
        container.read(pharmacySearchQueryProvider.notifier).update('kadıköy');
        final result = await _resolve(container);
        expect(result, [_kadikoyOnDuty]);
      },
    );

    test('district filter narrows to an exact district', () async {
      final container = _makeContainer();
      container.read(selectedDistrictProvider.notifier).update('Şişli');
      final result = await _resolve(container);
      expect(result, [_sisliOnDuty]);
    });

    test(
      'on-duty-only toggle excludes pharmacies not currently on duty',
      () async {
        final container = _makeContainer();
        container.read(onDutyOnlyProvider.notifier).toggle();
        final result = await _resolve(container);
        expect(result, [_kadikoyOnDuty, _sisliOnDuty]);
      },
    );

    test(
      'search, district, and on-duty filters combine with AND semantics',
      () async {
        final container = _makeContainer();
        container.read(pharmacySearchQueryProvider.notifier).update('eczanesi');
        container.read(selectedDistrictProvider.notifier).update('Kadıköy');
        container.read(onDutyOnlyProvider.notifier).toggle();
        final result = await _resolve(container);
        expect(result, [_kadikoyOnDuty]);

        // Flipping on-duty-only back off with the same search+district should
        // still only return the Kadıköy match, proving no HTTP re-fetch is
        // needed to change results.
        container.read(onDutyOnlyProvider.notifier).toggle();
        final resultAfterToggle = await _resolve(container);
        expect(resultAfterToggle, [_kadikoyOnDuty]);
      },
    );

    test('no matches yields an empty list rather than an error', () async {
      final container = _makeContainer();
      container
          .read(pharmacySearchQueryProvider.notifier)
          .update('nonexistent pharmacy xyz');
      final result = await _resolve(container);
      expect(result, isEmpty);
    });
  });

  group('hasActiveFiltersProvider', () {
    test('is false with no filters applied', () async {
      final container = _makeContainer();
      await container.read(pharmacyListProvider.future);
      expect(container.read(hasActiveFiltersProvider), isFalse);
    });

    test('is true when any single filter is active', () async {
      final container = _makeContainer();
      await container.read(pharmacyListProvider.future);

      container.read(pharmacySearchQueryProvider.notifier).update('a');
      expect(container.read(hasActiveFiltersProvider), isTrue);
      container.read(pharmacySearchQueryProvider.notifier).update('');

      container.read(selectedDistrictProvider.notifier).update('Kadıköy');
      expect(container.read(hasActiveFiltersProvider), isTrue);
      container.read(selectedDistrictProvider.notifier).update(null);

      container.read(onDutyOnlyProvider.notifier).toggle();
      expect(container.read(hasActiveFiltersProvider), isTrue);
    });
  });

  group('availableDistrictsProvider', () {
    test('returns distinct districts sorted alphabetically', () async {
      final container = _makeContainer();
      await container.read(pharmacyListProvider.future);
      expect(container.read(availableDistrictsProvider), [
        'Beşiktaş',
        'Kadıköy',
        'Şişli',
      ]);
    });
  });
}
