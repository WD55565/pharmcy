import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pharmacy_favorites_provider.g.dart';

/// In-memory set of favorited pharmacy ids.
///
/// This is UI/architecture prep only, as requested — state is lost on app
/// restart. Swapping in real persistence (e.g. a local database or
/// key-value store) later only means changing this provider's
/// implementation; nothing in the presentation layer needs to change.
@riverpod
class PharmacyFavorites extends _$PharmacyFavorites {
  @override
  Set<int> build() => const {};

  bool isFavorite(int pharmacyId) => state.contains(pharmacyId);

  void toggle(int pharmacyId) {
    state = state.contains(pharmacyId)
        ? ({...state}..remove(pharmacyId))
        : ({...state}..add(pharmacyId));
  }
}
