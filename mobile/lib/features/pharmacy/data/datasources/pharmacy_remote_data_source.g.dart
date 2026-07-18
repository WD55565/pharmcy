// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pharmacyRemoteDataSource)
final pharmacyRemoteDataSourceProvider = PharmacyRemoteDataSourceProvider._();

final class PharmacyRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PharmacyRemoteDataSource,
          PharmacyRemoteDataSource,
          PharmacyRemoteDataSource
        >
    with $Provider<PharmacyRemoteDataSource> {
  PharmacyRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pharmacyRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pharmacyRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PharmacyRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PharmacyRemoteDataSource create(Ref ref) {
    return pharmacyRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PharmacyRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PharmacyRemoteDataSource>(value),
    );
  }
}

String _$pharmacyRemoteDataSourceHash() =>
    r'4a69b77299f7e740f61fa72c0872dae08175b16e';
