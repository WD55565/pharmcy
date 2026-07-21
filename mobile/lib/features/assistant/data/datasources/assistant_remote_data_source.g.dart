// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assistantRemoteDataSource)
final assistantRemoteDataSourceProvider = AssistantRemoteDataSourceProvider._();

final class AssistantRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AssistantRemoteDataSource,
          AssistantRemoteDataSource,
          AssistantRemoteDataSource
        >
    with $Provider<AssistantRemoteDataSource> {
  AssistantRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assistantRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assistantRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AssistantRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssistantRemoteDataSource create(Ref ref) {
    return assistantRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssistantRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssistantRemoteDataSource>(value),
    );
  }
}

String _$assistantRemoteDataSourceHash() =>
    r'fd013b0516e9435b5638c3a3009e78413878e31b';
