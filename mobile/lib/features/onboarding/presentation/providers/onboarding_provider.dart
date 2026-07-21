import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../assistant/domain/entities/assistant_language.dart';
import '../../data/datasources/onboarding_local_data_source.dart';

part 'onboarding_provider.g.dart';

/// Whether the first-visit onboarding flow still needs to be shown. `true`
/// only until [OnboardingCompleted.complete] is called (or it was already
/// completed on a previous visit, read once at startup).
@Riverpod(keepAlive: true)
class OnboardingCompleted extends _$OnboardingCompleted {
  @override
  bool build() => ref.watch(onboardingLocalDataSourceProvider).hasCompletedOnboarding();

  Future<void> complete() async {
    await ref.read(onboardingLocalDataSourceProvider).markOnboardingCompleted();
    state = true;
  }
}

/// The language chosen on the onboarding Language Selection screen. Kept
/// fully independent from the assistant chat's own language picker (which
/// is unaffected by this) so the existing chatbot behavior is untouched.
@Riverpod(keepAlive: true)
class OnboardingLanguage extends _$OnboardingLanguage {
  @override
  AssistantLanguage? build() => ref.watch(onboardingLocalDataSourceProvider).loadLanguage();

  Future<void> select(AssistantLanguage language) async {
    await ref.read(onboardingLocalDataSourceProvider).saveLanguage(language);
    state = language;
  }
}
