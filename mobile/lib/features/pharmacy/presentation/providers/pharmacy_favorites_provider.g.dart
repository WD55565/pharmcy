// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// In-memory set of favorited pharmacy ids.
///
/// This is UI/architecture prep only, as requested — state is lost on app
/// restart. Swapping in real persistence (e.g. a local database or
/// key-value store) later only means changing this provider's
/// implementation; nothing in the presentation layer needs to change.

@ProviderFor(PharmacyFavorites)
final pharmacyFavoritesProvider = PharmacyFavoritesProvider._();

/// In-memory set of favorited pharmacy ids.
///
/// This is UI/architecture prep only, as requested — state is lost on app
/// restart. Swapping in real persistence (e.g. a local database or
/// key-value store) later only means changing this provider's
/// implementation; nothing in the presentation layer needs to change.
final class PharmacyFavoritesProvider
    extends $NotifierProvider<PharmacyFavorites, Set<int>> {
  /// In-memory set of favorited pharmacy ids.
  ///
  /// This is UI/architecture prep only, as requested — state is lost on app
  /// restart. Swapping in real persistence (e.g. a local database or
  /// key-value store) later only means changing this provider's
  /// implementation; nothing in the presentation layer needs to change.
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

String _$pharmacyFavoritesHash() => r'882b9eb2905673023c2346cf16f364e5c9160b1c';

/// In-memory set of favorited pharmacy ids.
///
/// This is UI/architecture prep only, as requested — state is lost on app
/// restart. Swapping in real persistence (e.g. a local database or
/// key-value store) later only means changing this provider's
/// implementation; nothing in the presentation layer needs to change.

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
