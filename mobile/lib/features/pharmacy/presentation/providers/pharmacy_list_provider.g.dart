// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches the full pharmacy list from the backend. Search and district
/// filtering are applied on top of this by [filteredPharmaciesProvider]
/// rather than re-fetching, since the backend only exposes `GET /pharmacies`
/// (no query parameters).

@ProviderFor(PharmacyList)
final pharmacyListProvider = PharmacyListProvider._();

/// Fetches the full pharmacy list from the backend. Search and district
/// filtering are applied on top of this by [filteredPharmaciesProvider]
/// rather than re-fetching, since the backend only exposes `GET /pharmacies`
/// (no query parameters).
final class PharmacyListProvider
    extends $AsyncNotifierProvider<PharmacyList, List<Pharmacy>> {
  /// Fetches the full pharmacy list from the backend. Search and district
  /// filtering are applied on top of this by [filteredPharmaciesProvider]
  /// rather than re-fetching, since the backend only exposes `GET /pharmacies`
  /// (no query parameters).
  PharmacyListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pharmacyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pharmacyListHash();

  @$internal
  @override
  PharmacyList create() => PharmacyList();
}

String _$pharmacyListHash() => r'd2d5572ec2dcf2cab0c6b5e68fb5f9cfb4b1a0bd';

/// Fetches the full pharmacy list from the backend. Search and district
/// filtering are applied on top of this by [filteredPharmaciesProvider]
/// rather than re-fetching, since the backend only exposes `GET /pharmacies`
/// (no query parameters).

abstract class _$PharmacyList extends $AsyncNotifier<List<Pharmacy>> {
  FutureOr<List<Pharmacy>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Pharmacy>>, List<Pharmacy>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Pharmacy>>, List<Pharmacy>>,
              AsyncValue<List<Pharmacy>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
