import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pharmacy/data/datasources/pharmacy_favorites_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PharmacyFavoritesLocalDataSource', () {
    test('loadFavoriteIds returns an empty set when nothing is stored', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = PharmacyFavoritesLocalDataSource(prefs);

      expect(dataSource.loadFavoriteIds(), isEmpty);
    });

    test('saveFavoriteIds persists ids that loadFavoriteIds can read back', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = PharmacyFavoritesLocalDataSource(prefs);

      await dataSource.saveFavoriteIds({1, 5, 42});

      expect(dataSource.loadFavoriteIds(), {1, 5, 42});
    });

    test('a new data source instance reads what a previous one saved', () async {
      // Simulates an app restart: SharedPreferences' mock store is shared
      // across getInstance() calls within the same test, so a second
      // instance should see the first one's writes.
      SharedPreferences.setMockInitialValues({});
      final firstDataSource = PharmacyFavoritesLocalDataSource(
        await SharedPreferences.getInstance(),
      );
      await firstDataSource.saveFavoriteIds({7, 8});

      final secondDataSource = PharmacyFavoritesLocalDataSource(
        await SharedPreferences.getInstance(),
      );

      expect(secondDataSource.loadFavoriteIds(), {7, 8});
    });

    test('saving an empty set clears previously stored favorites', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = PharmacyFavoritesLocalDataSource(prefs);

      await dataSource.saveFavoriteIds({1, 2});
      await dataSource.saveFavoriteIds({});

      expect(dataSource.loadFavoriteIds(), isEmpty);
    });
  });
}
