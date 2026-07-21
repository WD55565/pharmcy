import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/pharmacy_favorites_local_data_source.dart';

part 'pharmacy_favorites_provider.g.dart';

/// Set of favorited pharmacy ids, persisted on-device via
/// [PharmacyFavoritesLocalDataSource] (`SharedPreferences`). Loaded
/// synchronously from the already-initialized data source (see
/// `bootstrap()`), so there's no loading state for the favorite icon —
/// it's available immediately on first frame.
@riverpod
class PharmacyFavorites extends _$PharmacyFavorites {
  @override
  Set<int> build() {
    return ref.watch(pharmacyFavoritesLocalDataSourceProvider).loadFavoriteIds();
  }

  bool isFavorite(int pharmacyId) => state.contains(pharmacyId);

  void toggle(int pharmacyId) {
    final updated = state.contains(pharmacyId)
        ? ({...state}..remove(pharmacyId))
        : ({...state}..add(pharmacyId));
    state = updated;
    ref.read(pharmacyFavoritesLocalDataSourceProvider).saveFavoriteIds(updated);
  }
}
