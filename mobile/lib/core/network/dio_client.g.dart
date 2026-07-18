// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Single, app-wide [Dio] instance pointed at the Spring Boot backend
/// (`api.apiBaseUrl` comes from the active [AppConfig], never hardcoded).
/// Feature-level data sources depend on this provider rather than
/// constructing their own Dio instances.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// Single, app-wide [Dio] instance pointed at the Spring Boot backend
/// (`api.apiBaseUrl` comes from the active [AppConfig], never hardcoded).
/// Feature-level data sources depend on this provider rather than
/// constructing their own Dio instances.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Single, app-wide [Dio] instance pointed at the Spring Boot backend
  /// (`api.apiBaseUrl` comes from the active [AppConfig], never hardcoded).
  /// Feature-level data sources depend on this provider rather than
  /// constructing their own Dio instances.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'14cf5328184ff658c45377ca343bd710219dfc77';
