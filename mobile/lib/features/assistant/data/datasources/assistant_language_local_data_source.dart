import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/assistant_language.dart';

const _languageCodeKey = 'assistant_language_code';

/// Persists the user's chosen assistant conversation language so the
/// language picker is only shown once (until the user changes it from the
/// chat header).
class AssistantLanguageLocalDataSource {
  AssistantLanguageLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  /// `null` means no language has been chosen yet — the picker should show.
  AssistantLanguage? loadLanguage() {
    return AssistantLanguage.fromCode(_prefs.getString(_languageCodeKey));
  }

  Future<void> saveLanguage(AssistantLanguage language) {
    return _prefs.setString(_languageCodeKey, language.code);
  }
}

/// Overridden in `bootstrap()` with a real, already-initialized
/// [SharedPreferences] instance, matching
/// `pharmacyFavoritesLocalDataSourceProvider`'s pattern.
final assistantLanguageLocalDataSourceProvider = Provider<AssistantLanguageLocalDataSource>((
  ref,
) {
  throw UnimplementedError(
    'assistantLanguageLocalDataSourceProvider was not overridden. '
    'Launch the app through bootstrap() with SharedPreferences ready.',
  );
});
