// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches a single pharmacy by id for the details screen. Keyed by [id] so
/// each pharmacy detail has its own independent cached/async state.

@ProviderFor(PharmacyDetail)
final pharmacyDetailProvider = PharmacyDetailFamily._();

/// Fetches a single pharmacy by id for the details screen. Keyed by [id] so
/// each pharmacy detail has its own independent cached/async state.
final class PharmacyDetailProvider
    extends $AsyncNotifierProvider<PharmacyDetail, Pharmacy> {
  /// Fetches a single pharmacy by id for the details screen. Keyed by [id] so
  /// each pharmacy detail has its own independent cached/async state.
  PharmacyDetailProvider._({
    required PharmacyDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pharmacyDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pharmacyDetailHash();

  @override
  String toString() {
    return r'pharmacyDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PharmacyDetail create() => PharmacyDetail();

  @override
  bool operator ==(Object other) {
    return other is PharmacyDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pharmacyDetailHash() => r'7844cec73a20dd19d114f44ec842224c99673cb9';

/// Fetches a single pharmacy by id for the details screen. Keyed by [id] so
/// each pharmacy detail has its own independent cached/async state.

final class PharmacyDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          PharmacyDetail,
          AsyncValue<Pharmacy>,
          Pharmacy,
          FutureOr<Pharmacy>,
          int
        > {
  PharmacyDetailFamily._()
    : super(
        retry: null,
        name: r'pharmacyDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fetches a single pharmacy by id for the details screen. Keyed by [id] so
  /// each pharmacy detail has its own independent cached/async state.

  PharmacyDetailProvider call(int id) =>
      PharmacyDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'pharmacyDetailProvider';
}

/// Fetches a single pharmacy by id for the details screen. Keyed by [id] so
/// each pharmacy detail has its own independent cached/async state.

abstract class _$PharmacyDetail extends $AsyncNotifier<Pharmacy> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<Pharmacy> build(int id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Pharmacy>, Pharmacy>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Pharmacy>, Pharmacy>,
              AsyncValue<Pharmacy>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
