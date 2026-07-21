import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/assistant/data/datasources/assistant_language_local_data_source.dart';
import 'package:mobile/features/assistant/domain/entities/assistant_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AssistantLanguageLocalDataSource', () {
    test('loadLanguage returns null when nothing is stored (first launch)', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = AssistantLanguageLocalDataSource(prefs);

      expect(dataSource.loadLanguage(), isNull);
    });

    test('saveLanguage persists a language that loadLanguage reads back', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = AssistantLanguageLocalDataSource(prefs);

      await dataSource.saveLanguage(AssistantLanguage.arabic);

      expect(dataSource.loadLanguage(), AssistantLanguage.arabic);
    });

    test('a new data source instance reads what a previous one saved', () async {
      SharedPreferences.setMockInitialValues({});
      final first = AssistantLanguageLocalDataSource(await SharedPreferences.getInstance());
      await first.saveLanguage(AssistantLanguage.turkish);

      final second = AssistantLanguageLocalDataSource(await SharedPreferences.getInstance());

      expect(second.loadLanguage(), AssistantLanguage.turkish);
    });

    test('saveLanguage overwrites a previous choice', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = AssistantLanguageLocalDataSource(prefs);

      await dataSource.saveLanguage(AssistantLanguage.english);
      await dataSource.saveLanguage(AssistantLanguage.arabic);

      expect(dataSource.loadLanguage(), AssistantLanguage.arabic);
    });
  });
}
