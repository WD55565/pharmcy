// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Set of favorited pharmacy ids, persisted on-device via
/// [PharmacyFavoritesLocalDataSource] (`SharedPreferences`). Loaded
/// synchronously from the already-initialized data source (see
/// `bootstrap()`), so there's no loading state for the favorite icon —
/// it's available immediately on first frame.

@ProviderFor(PharmacyFavorites)
final pharmacyFavoritesProvider = PharmacyFavoritesProvider._();

/// Set of favorited pharmacy ids, persisted on-device via
/// [PharmacyFavoritesLocalDataSource] (`SharedPreferences`). Loaded
/// synchronously from the already-initialized data source (see
/// `bootstrap()`), so there's no loading state for the favorite icon —
/// it's available immediately on first frame.
final class PharmacyFavoritesProvider
    extends $NotifierProvider<PharmacyFavorites, Set<int>> {
  /// Set of favorited pharmacy ids, persisted on-device via
  /// [PharmacyFavoritesLocalDataSource] (`SharedPreferences`). Loaded
  /// synchronously from the already-initialized data source (see
  /// `bootstrap()`), so there's no loading state for the favorite icon —
  /// it's available immediately on first frame.
  PharmacyFavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pharmacyFavoritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pharmacyFavoritesHash();

  @$internal
  @override
  PharmacyFavorites create() => PharmacyFavorites();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<int>>(value),
    );
  }
}

String _$pharmacyFavoritesHash() => r'f88e817ea2d0baebd8db9221c6a8118a73d91c4b';

/// Set of favorited pharmacy ids, persisted on-device via
/// [PharmacyFavoritesLocalDataSource] (`SharedPreferences`). Loaded
/// synchronously from the already-initialized data source (see
/// `bootstrap()`), so there's no loading state for the favorite icon —
/// it's available immediately on first frame.

abstract class _$PharmacyFavorites extends $Notifier<Set<int>> {
  Set<int> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<int>, Set<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<int>, Set<int>>,
              Set<int>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
