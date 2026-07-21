import '../../domain/entities/assistant_language.dart';

/// UI chrome text for the assistant (dialog titles, hints, buttons) in each
/// supported conversation language. Deliberately separate from the app's
/// own `AppLocalizations` (Turkish/English only) — the assistant's
/// language is a per-feature choice (including Arabic) that doesn't flip
/// the rest of the app's UI language.
class AssistantStrings {
  const AssistantStrings._({
    required this.chooseLanguageTitle,
    required this.chooseLanguageBody,
    required this.title,
    required this.inputHint,
    required this.clearConversation,
    required this.clearConversationConfirm,
    required this.emptyConversation,
    required this.changeLanguageTooltip,
    required this.minimizeTooltip,
    required this.openAssistantTooltip,
    required this.cancel,
    required this.serviceUnavailable,
  });

  final String chooseLanguageTitle;
  final String chooseLanguageBody;
  final String title;
  final String inputHint;
  final String clearConversation;
  final String clearConversationConfirm;
  final String emptyConversation;
  final String changeLanguageTooltip;
  final String minimizeTooltip;
  final String openAssistantTooltip;
  final String cancel;

  /// Shown as a chat bubble (not a dialog) when the backend/AI call fails,
  /// so the failure reads as part of the conversation rather than a
  /// separate error UI.
  final String serviceUnavailable;

  static AssistantStrings of(AssistantLanguage language) => switch (language) {
    AssistantLanguage.english => _english,
    AssistantLanguage.turkish => _turkish,
    AssistantLanguage.arabic => _arabic,
  };

  static const _english = AssistantStrings._(
    chooseLanguageTitle: 'Choose a language',
    chooseLanguageBody: 'Which language would you like the assistant to reply in?',
    title: 'Pharmacy Assistant',
    inputHint: 'Ask a question…',
    clearConversation: 'Clear conversation',
    clearConversationConfirm: 'Clear the whole conversation? This cannot be undone.',
    emptyConversation: 'Ask me about on-duty pharmacies, hours, or districts.',
    changeLanguageTooltip: 'Change language',
    minimizeTooltip: 'Minimize',
    openAssistantTooltip: 'Open assistant',
    cancel: 'Cancel',
    serviceUnavailable: "Sorry, I'm having trouble connecting right now. Please try again in a moment.",
  );

  static const _turkish = AssistantStrings._(
    chooseLanguageTitle: 'Bir dil seçin',
    chooseLanguageBody: 'Asistanın hangi dilde yanıt vermesini istersiniz?',
    title: 'Eczane Asistanı',
    inputHint: 'Bir soru sorun…',
    clearConversation: 'Konuşmayı temizle',
    clearConversationConfirm: 'Tüm konuşma silinsin mi? Bu işlem geri alınamaz.',
    emptyConversation: 'Nöbetçi eczaneler, saatler veya ilçeler hakkında sorabilirsiniz.',
    changeLanguageTooltip: 'Dili değiştir',
    minimizeTooltip: 'Küçült',
    openAssistantTooltip: 'Asistanı aç',
    cancel: 'Vazgeç',
    serviceUnavailable: 'Üzgünüm, şu anda bağlanmakta sorun yaşıyorum. Lütfen birazdan tekrar deneyin.',
  );

  static const _arabic = AssistantStrings._(
    chooseLanguageTitle: 'اختر لغة',
    chooseLanguageBody: 'بأي لغة تريد أن يرد المساعد؟',
    title: 'مساعد الصيدلية',
    inputHint: 'اطرح سؤالاً…',
    clearConversation: 'مسح المحادثة',
    clearConversationConfirm: 'هل تريد مسح المحادثة بالكامل؟ لا يمكن التراجع عن هذا.',
    emptyConversation: 'اسألني عن الصيدليات المناوبة أو ساعات العمل أو المناطق.',
    changeLanguageTooltip: 'تغيير اللغة',
    minimizeTooltip: 'تصغير',
    openAssistantTooltip: 'فتح المساعد',
    cancel: 'إلغاء',
    serviceUnavailable: 'عذرًا، أواجه مشكلة في الاتصال الآن. يرجى المحاولة مرة أخرى بعد قليل.',
  );
}
