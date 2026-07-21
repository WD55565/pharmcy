// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssistantConversation)
final assistantConversationProvider = AssistantConversationProvider._();

final class AssistantConversationProvider
    extends
        $NotifierProvider<AssistantConversation, AssistantConversationState> {
  AssistantConversationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assistantConversationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assistantConversationHash();

  @$internal
  @override
  AssistantConversation create() => AssistantConversation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssistantConversationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssistantConversationState>(value),
    );
  }
}

String _$assistantConversationHash() =>
    r'4de89011c784ebb1b7b1bdf48e5f2c4dbc0042ff';

abstract class _$AssistantConversation
    extends $Notifier<AssistantConversationState> {
  AssistantConversationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AssistantConversationState, AssistantConversationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AssistantConversationState,
                AssistantConversationState
              >,
              AssistantConversationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
