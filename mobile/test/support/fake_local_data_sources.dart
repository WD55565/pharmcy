import 'package:mobile/features/assistant/data/datasources/assistant_language_local_data_source.dart';
import 'package:mobile/features/assistant/domain/entities/assistant_language.dart';
import 'package:mobile/features/pharmacy/data/datasources/pharmacy_favorites_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Never actually called — the fakes below override every method that
/// would otherwise touch it, so tests never hit real on-device storage.
class UnusedPrefs implements SharedPreferences {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('SharedPreferences should not be used directly in tests');
}

/// In-memory stand-in for the real SharedPreferences-backed favorites data
/// source.
class FakeFavoritesLocalDataSource extends PharmacyFavoritesLocalDataSource {
  FakeFavoritesLocalDataSource() : super(UnusedPrefs());

  Set<int> _stored = {};

  @override
  Set<int> loadFavoriteIds() => _stored;

  @override
  Future<void> saveFavoriteIds(Set<int> ids) async => _stored = ids;
}

/// In-memory stand-in for the real SharedPreferences-backed assistant
/// language data source. Defaults to no language chosen, matching a fresh
/// install, unless [initial] is provided.
class FakeAssistantLanguageLocalDataSource extends AssistantLanguageLocalDataSource {
  FakeAssistantLanguageLocalDataSource({AssistantLanguage? initial})
    : _stored = initial,
      super(UnusedPrefs());

  AssistantLanguage? _stored;

  @override
  AssistantLanguage? loadLanguage() => _stored;

  @override
  Future<void> saveLanguage(AssistantLanguage language) async => _stored = language;
}
