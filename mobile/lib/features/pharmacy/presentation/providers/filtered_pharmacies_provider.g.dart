// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_pharmacies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// [pharmacyListProvider]'s data, narrowed by the current search query,
/// district selection, and on-duty toggle. All filtering happens in memory
/// on the already-fetched list — no additional HTTP requests are made while
/// the user types or changes filters. Loading/error states pass through
/// unchanged so the screen only needs to handle one [AsyncValue].

@ProviderFor(filteredPharmacies)
final filteredPharmaciesProvider = FilteredPharmaciesProvider._();

/// [pharmacyListProvider]'s data, narrowed by the current search query,
/// district selection, and on-duty toggle. All filtering happens in memory
/// on the already-fetched list — no additional HTTP requests are made while
/// the user types or changes filters. Loading/error states pass through
/// unchanged so the screen only needs to handle one [AsyncValue].

final class FilteredPharmaciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Pharmacy>>,
          AsyncValue<List<Pharmacy>>,
          AsyncValue<List<Pharmacy>>
        >
    with $Provider<AsyncValue<List<Pharmacy>>> {
  /// [pharmacyListProvider]'s data, narrowed by the current search query,
  /// district selection, and on-duty toggle. All filtering happens in memory
  /// on the already-fetched list — no additional HTTP requests are made while
  /// the user types or changes filters. Loading/error states pass through
  /// unchanged so the screen only needs to handle one [AsyncValue].
  FilteredPharmaciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredPharmaciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredPharmaciesHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<Pharmacy>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<Pharmacy>> create(Ref ref) {
    return filteredPharmacies(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Pharmacy>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Pharmacy>>>(value),
    );
  }
}

String _$filteredPharmaciesHash() =>
    r'd8125b3daa39590c536581c954aed38961feb617';

/// Distinct, sorted district names from the full (unfiltered) list, used to
/// populate the district filter chips.

@ProviderFor(availableDistricts)
final availableDistrictsProvider = AvailableDistrictsProvider._();

/// Distinct, sorted district names from the full (unfiltered) list, used to
/// populate the district filter chips.

final class AvailableDistrictsProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  /// Distinct, sorted district names from the full (unfiltered) list, used to
  /// populate the district filter chips.
  AvailableDistrictsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableDistrictsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableDistrictsHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return availableDistricts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$availableDistrictsHash() =>
    r'49c3cd745d0839ac25e28be9c6ced24bc4398b06';
