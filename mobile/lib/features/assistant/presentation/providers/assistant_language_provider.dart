import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/assistant_language_local_data_source.dart';
import '../../domain/entities/assistant_language.dart';

part 'assistant_language_provider.g.dart';

/// The user's chosen assistant conversation language, persisted on-device.
/// `null` means no choice has been made yet — the launcher shows the
/// language picker in that case and only that case.
@riverpod
class AssistantLanguagePreference extends _$AssistantLanguagePreference {
  @override
  AssistantLanguage? build() {
    return ref.watch(assistantLanguageLocalDataSourceProvider).loadLanguage();
  }

  void select(AssistantLanguage language) {
    state = language;
    ref.read(assistantLanguageLocalDataSourceProvider).saveLanguage(language);
  }
}
