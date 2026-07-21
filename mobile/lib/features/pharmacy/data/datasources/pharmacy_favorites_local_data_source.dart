import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _favoriteIdsKey = 'favorite_pharmacy_ids';

/// Persists favorited pharmacy ids to on-device key-value storage.
/// [SharedPreferences] only stores strings, so ids are stored as their
/// string form under a single key.
class PharmacyFavoritesLocalDataSource {
  PharmacyFavoritesLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  Set<int> loadFavoriteIds() {
    final stored = _prefs.getStringList(_favoriteIdsKey) ?? const [];
    return stored.map(int.parse).toSet();
  }

  Future<void> saveFavoriteIds(Set<int> ids) {
    return _prefs.setStringList(
      _favoriteIdsKey,
      ids.map((id) => id.toString()).toList(),
    );
  }
}

/// Overridden in `bootstrap()` with a real, already-initialized
/// [SharedPreferences] instance — reading this before that happens is a
/// programming error and throws intentionally, matching the pattern used
/// by `appConfigProvider`.
final pharmacyFavoritesLocalDataSourceProvider =
    Provider<PharmacyFavoritesLocalDataSource>((ref) {
      throw UnimplementedError(
        'pharmacyFavoritesLocalDataSourceProvider was not overridden. '
        'Launch the app through bootstrap() with SharedPreferences ready.',
      );
    });
