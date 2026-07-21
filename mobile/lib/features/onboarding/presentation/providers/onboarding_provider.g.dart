// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the first-visit onboarding flow still needs to be shown. `true`
/// only until [OnboardingCompleted.complete] is called (or it was already
/// completed on a previous visit, read once at startup).

@ProviderFor(OnboardingCompleted)
final onboardingCompletedProvider = OnboardingCompletedProvider._();

/// Whether the first-visit onboarding flow still needs to be shown. `true`
/// only until [OnboardingCompleted.complete] is called (or it was already
/// completed on a previous visit, read once at startup).
final class OnboardingCompletedProvider
    extends $NotifierProvider<OnboardingCompleted, bool> {
  /// Whether the first-visit onboarding flow still needs to be shown. `true`
  /// only until [OnboardingCompleted.complete] is called (or it was already
  /// completed on a previous visit, read once at startup).
  OnboardingCompletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedHash();

  @$internal
  @override
  OnboardingCompleted create() => OnboardingCompleted();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingCompletedHash() =>
    r'b18bc97b029235c0f52ed50d587d8012d5388b19';

/// Whether the first-visit onboarding flow still needs to be shown. `true`
/// only until [OnboardingCompleted.complete] is called (or it was already
/// completed on a previous visit, read once at startup).

abstract class _$OnboardingCompleted extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The language chosen on the onboarding Language Selection screen. Kept
/// fully independent from the assistant chat's own language picker (which
/// is unaffected by this) so the existing chatbot behavior is untouched.

@ProviderFor(OnboardingLanguage)
final onboardingLanguageProvider = OnboardingLanguageProvider._();

/// The language chosen on the onboarding Language Selection screen. Kept
/// fully independent from the assistant chat's own language picker (which
/// is unaffected by this) so the existing chatbot behavior is untouched.
final class OnboardingLanguageProvider
    extends $NotifierProvider<OnboardingLanguage, AssistantLanguage?> {
  /// The language chosen on the onboarding Language Selection screen. Kept
  /// fully independent from the assistant chat's own language picker (which
  /// is unaffected by this) so the existing chatbot behavior is untouched.
  OnboardingLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingLanguageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingLanguageHash();

  @$internal
  @override
  OnboardingLanguage create() => OnboardingLanguage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssistantLanguage? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssistantLanguage?>(value),
    );
  }
}

String _$onboardingLanguageHash() =>
    r'9760e43b8ad553f20d9072e78ccbdddaab666267';

/// The language chosen on the onboarding Language Selection screen. Kept
/// fully independent from the assistant chat's own language picker (which
/// is unaffected by this) so the existing chatbot behavior is untouched.

abstract class _$OnboardingLanguage extends $Notifier<AssistantLanguage?> {
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
