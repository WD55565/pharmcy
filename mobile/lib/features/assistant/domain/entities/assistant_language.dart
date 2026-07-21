/// Language the assistant converses in — independent of the app's own UI
/// locale (which stays Turkish/English). Chosen once by the user and
/// persisted; see `AssistantLanguageLocalDataSource`.
enum AssistantLanguage {
  arabic('ar'),
  english('en'),
  turkish('tr');

  const AssistantLanguage(this.code);

  final String code;

  String get nativeName => switch (this) {
    AssistantLanguage.arabic => 'العربية',
    AssistantLanguage.english => 'English',
    AssistantLanguage.turkish => 'Türkçe',
  };

  bool get isRightToLeft => this == AssistantLanguage.arabic;

  static AssistantLanguage? fromCode(String? code) {
    for (final language in AssistantLanguage.values) {
      if (language.code == code) return language;
    }
    return null;
  }
}
