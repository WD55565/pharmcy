// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's chosen assistant conversation language, persisted on-device.
/// `null` means no choice has been made yet — the launcher shows the
/// language picker in that case and only that case.

@ProviderFor(AssistantLanguagePreference)
final assistantLanguagePreferenceProvider =
    AssistantLanguagePreferenceProvider._();

/// The user's chosen assistant conversation language, persisted on-device.
/// `null` means no choice has been made yet — the launcher shows the
/// language picker in that case and only that case.
final class AssistantLanguagePreferenceProvider
    extends $NotifierProvider<AssistantLanguagePreference, AssistantLanguage?> {
  /// The user's chosen assistant conversation language, persisted on-device.
  /// `null` means no choice has been made yet — the launcher shows the
  /// language picker in that case and only that case.
  AssistantLanguagePreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assistantLanguagePreferenceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assistantLanguagePreferenceHash();

  @$internal
  @override
  AssistantLanguagePreference create() => AssistantLanguagePreference();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssistantLanguage? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssistantLanguage?>(value),
    );
  }
}

String _$assistantLanguagePreferenceHash() =>
    r'e73077653d649a2b641c0fcdfa0f4def76158c6c';

/// The user's chosen assistant conversation language, persisted on-device.
/// `null` means no choice has been made yet — the launcher shows the
/// language picker in that case and only that case.

abstract class _$AssistantLanguagePreference
    extends $Notifier<AssistantLanguage?> {
  AssistantLanguage? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AssistantLanguage?, AssistantLanguage?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AssistantLanguage?, AssistantLanguage?>,
              AssistantLanguage?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
