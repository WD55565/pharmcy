// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_assistant_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Demo Mode: the app's default [AssistantRepository] while the Gemini
/// integration is disabled (pending API billing/credits — see
/// `GeminiAssistantRepositoryImpl`). Swapping back to Gemini once it's
/// ready only requires changing this one provider body; nothing in
/// `presentation/` depends on which implementation is wired here.

@ProviderFor(assistantRepository)
final assistantRepositoryProvider = AssistantRepositoryProvider._();

/// Demo Mode: the app's default [AssistantRepository] while the Gemini
/// integration is disabled (pending API billing/credits — see
/// `GeminiAssistantRepositoryImpl`). Swapping back to Gemini once it's
/// ready only requires changing this one provider body; nothing in
/// `presentation/` depends on which implementation is wired here.

final class AssistantRepositoryProvider
    extends
        $FunctionalProvider<
          AssistantRepository,
          AssistantRepository,
          AssistantRepository
        >
    with $Provider<AssistantRepository> {
  /// Demo Mode: the app's default [AssistantRepository] while the Gemini
  /// integration is disabled (pending API billing/credits — see
  /// `GeminiAssistantRepositoryImpl`). Swapping back to Gemini once it's
  /// ready only requires changing this one provider body; nothing in
  /// `presentation/` depends on which implementation is wired here.
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
    r'e28fe44d66e28d7c9703e2a8544df7da04798b8a';
