// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_filters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Current search-by-name query, updated as the user types.

@ProviderFor(PharmacySearchQuery)
final pharmacySearchQueryProvider = PharmacySearchQueryProvider._();

/// Current search-by-name query, updated as the user types.
final class PharmacySearchQueryProvider
    extends $NotifierProvider<PharmacySearchQuery, String> {
  /// Current search-by-name query, updated as the user types.
  PharmacySearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pharmacySearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pharmacySearchQueryHash();

  @$internal
  @override
  PharmacySearchQuery create() => PharmacySearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$pharmacySearchQueryHash() =>
    r'e9dbe49553fac5806c1f73abdb3470bcf6ec642f';

/// Current search-by-name query, updated as the user types.

abstract class _$PharmacySearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Currently selected district filter; `null` means "all districts".

@ProviderFor(SelectedDistrict)
final selectedDistrictProvider = SelectedDistrictProvider._();

/// Currently selected district filter; `null` means "all districts".
final class SelectedDistrictProvider
    extends $NotifierProvider<SelectedDistrict, String?> {
  /// Currently selected district filter; `null` means "all districts".
  SelectedDistrictProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDistrictProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDistrictHash();

  @$internal
  @override
  SelectedDistrict create() => SelectedDistrict();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedDistrictHash() => r'fec25148ce908631bc58a54cbd38d7b8414d95f5';

/// Currently selected district filter; `null` means "all districts".

abstract class _$SelectedDistrict extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Whether the list should be narrowed to on-duty pharmacies only.

@ProviderFor(OnDutyOnly)
final onDutyOnlyProvider = OnDutyOnlyProvider._();

/// Whether the list should be narrowed to on-duty pharmacies only.
final class OnDutyOnlyProvider extends $NotifierProvider<OnDutyOnly, bool> {
  /// Whether the list should be narrowed to on-duty pharmacies only.
  OnDutyOnlyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onDutyOnlyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onDutyOnlyHash();

  @$internal
  @override
  OnDutyOnly create() => OnDutyOnly();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onDutyOnlyHash() => r'424c6a901193844481a10ed6212e8086ef7a3b06';

/// Whether the list should be narrowed to on-duty pharmacies only.

abstract class _$OnDutyOnly extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// True when any of search/district/on-duty filters are currently active,
/// used to show/hide the "Clear Filters" action.

@ProviderFor(hasActiveFilters)
final hasActiveFiltersProvider = HasActiveFiltersProvider._();

/// True when any of search/district/on-duty filters are currently active,
/// used to show/hide the "Clear Filters" action.

final class HasActiveFiltersProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True when any of search/district/on-duty filters are currently active,
  /// used to show/hide the "Clear Filters" action.
  HasActiveFiltersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasActiveFiltersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasActiveFiltersHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasActiveFilters(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasActiveFiltersHash() => r'14e5306c23ff170003f8c7d60930bd442389816b';
