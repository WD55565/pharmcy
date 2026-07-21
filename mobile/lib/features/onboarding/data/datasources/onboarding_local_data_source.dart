import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../assistant/domain/entities/assistant_language.dart';

const _completedKey = 'onboarding_completed';
const _languageCodeKey = 'onboarding_language_code';

/// Persists whether the first-visit onboarding flow (splash → language →
/// welcome) has already been shown, so it only ever appears once per
/// install. Reuses [AssistantLanguage] as the onboarding language choice
/// (same three languages, same native-name/RTL metadata) rather than
/// duplicating an identical enum.
class OnboardingLocalDataSource {
  OnboardingLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  bool hasCompletedOnboarding() => _prefs.getBool(_completedKey) ?? false;

  Future<void> markOnboardingCompleted() => _prefs.setBool(_completedKey, true);

  AssistantLanguage? loadLanguage() {
    return AssistantLanguage.fromCode(_prefs.getString(_languageCodeKey));
  }

  Future<void> saveLanguage(AssistantLanguage language) {
    return _prefs.setString(_languageCodeKey, language.code);
  }
}

/// Overridden in `bootstrap()` with a real, already-initialized
/// [SharedPreferences] instance, matching
/// `assistantLanguageLocalDataSourceProvider`'s pattern.
final onboardingLocalDataSourceProvider = Provider<OnboardingLocalDataSource>((ref) {
  throw UnimplementedError(
    'onboardingLocalDataSourceProvider was not overridden. '
    'Launch the app through bootstrap() with SharedPreferences ready.',
  );
});
