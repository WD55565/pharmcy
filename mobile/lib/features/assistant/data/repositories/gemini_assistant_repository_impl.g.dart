// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_assistant_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assistantRepository)
final assistantRepositoryProvider = AssistantRepositoryProvider._();

final class AssistantRepositoryProvider
    extends
        $FunctionalProvider<
          AssistantRepository,
          AssistantRepository,
          AssistantRepository
        >
    with $Provider<AssistantRepository> {
  AssistantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assistantRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assistantRepositoryHash();

  @$internal
  @override
  $ProviderElement<AssistantRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssistantRepository create(Ref ref) {
    return assistantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssistantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssistantRepository>(value),
    );
  }
}

String _$assistantRepositoryHash() =>
    r'85daee7d9fd2bf9b3fe77001816318d43ddca900';
