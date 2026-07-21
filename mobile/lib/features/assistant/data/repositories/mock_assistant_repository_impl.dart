import 'dart:math';

import '../../../../core/network/result.dart';
import '../../../../core/utils/turkish_text.dart';
import '../../../pharmacy/domain/entities/pharmacy.dart';
import '../../../pharmacy/domain/repositories/pharmacy_repository.dart';
import '../../domain/entities/assistant_language.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/assistant_repository.dart';

/// Deterministic, offline stand-in for [GeminiAssistantRepositoryImpl] —
/// used in widget/unit tests so they don't depend on a live backend or AI
/// provider, and available as a manual fallback if the real one can't be
/// reached. Recognizes a handful of intents by keyword and, where
/// relevant, answers using the *real* pharmacy list via
/// [PharmacyRepository]; everything else falls back to a generic helpful
/// reply. Simulates network/"thinking" latency so the typing indicator has
/// something to show.
class MockAssistantRepositoryImpl implements AssistantRepository {
  MockAssistantRepositoryImpl(this._pharmacyRepository);

  final PharmacyRepository _pharmacyRepository;
  final Random _random = Random();
  int _nextId = 0;

  @override
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
    required AssistantLanguage language,
  }) async {
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(700)));

    final content = await _buildReply(userMessage, language);
    return ChatMessage(
      id: 'assistant-${_nextId++}-${DateTime.now().microsecondsSinceEpoch}',
      role: ChatMessageRole.assistant,
      content: content,
      sentAt: DateTime.now(),
    );
  }

  Future<String> _buildReply(String userMessage, AssistantLanguage language) async {
    final normalized = normalizeTurkish(userMessage.trim());

    if (normalized.isEmpty) {
      return _text(language, empty: true);
    }

    // normalizeTurkish only fixes I/İ casing — it does not strip Turkish
    // diacritics — so keywords must use the actual Turkish spelling
    // ('nöbetçi', not 'nobetci') to match real user input.
    if (_matchesAny(normalized, const [
      'nöbetçi', 'on duty', 'onduty', 'open now', 'مناوب', 'نوبتجي',
    ])) {
      return _onDutyReply(language);
    }

    if (_matchesAny(normalized, const [
      'saat', 'hour', 'opening', 'closing', 'ساعة', 'وقت',
    ])) {
      return _hoursReply(language);
    }

    if (_matchesAny(normalized, const [
      'ilçe', 'district', 'area', 'منطقة', 'حي',
    ])) {
      return _districtReply(language);
    }

    return _helpReply(language);
  }

  bool _matchesAny(String normalized, List<String> keywords) {
    return keywords.any((keyword) => normalized.contains(normalizeTurkish(keyword)));
  }

  Future<String> _onDutyReply(AssistantLanguage language) async {
    final result = await _pharmacyRepository.getPharmacies();
    return switch (result) {
      ResultSuccess(:final data) => _formatOnDutyList(
        data.where((pharmacy) => pharmacy.isOnDuty).toList(),
        language,
      ),
      ResultFailure() => _text(language, fetchFailed: true),
    };
  }

  String _formatOnDutyList(List<Pharmacy> onDuty, AssistantLanguage language) {
    if (onDuty.isEmpty) {
      return _text(language, noneOnDuty: true);
    }

    final buffer = StringBuffer(_text(language, onDutyIntro: true));
    buffer.writeln();
    buffer.writeln();
    for (final pharmacy in onDuty.take(5)) {
      buffer.writeln('- **${pharmacy.name}** (${pharmacy.district}) — ${pharmacy.phone}');
    }
    if (onDuty.length > 5) {
      buffer.writeln();
      buffer.writeln(_text(language, moreCount: onDuty.length - 5));
    }
    return buffer.toString().trim();
  }

  String _hoursReply(AssistantLanguage language) => _text(language, hours: true);

  String _districtReply(AssistantLanguage language) => _text(language, districts: true);

  String _helpReply(AssistantLanguage language) => _text(language, help: true);

  String _text(
    AssistantLanguage language, {
    bool empty = false,
    bool fetchFailed = false,
    bool noneOnDuty = false,
    bool onDutyIntro = false,
    int? moreCount,
    bool hours = false,
    bool districts = false,
    bool help = false,
  }) {
    switch (language) {
      case AssistantLanguage.english:
        if (empty) return "I didn't quite catch that — could you rephrase your question?";
        if (fetchFailed) return "I couldn't reach the pharmacy list right now. Please try again.";
        if (noneOnDuty) return 'No on-duty pharmacies are listed at the moment.';
        if (onDutyIntro) return "Here are the pharmacies currently on duty:";
        if (moreCount != null) return '...and $moreCount more. Use the district filter on the home screen to see them all.';
        if (hours) {
          return 'On-duty pharmacies typically cover the hours regular pharmacies are closed — often overnight '
              '(e.g. 20:00–08:00). Each pharmacy card and its detail page show its exact hours when available.';
        }
        if (districts) {
          return 'You can browse by district using the filter chips on the home screen (Kadıköy, Beşiktaş, Şişli, '
              'and more). Ask me "which pharmacies are on duty" for a live list.';
        }
        if (help) {
          return "I can help with on-duty pharmacies, opening hours, and districts. Try asking things like "
              '*"which pharmacies are on duty right now?"* or *"what are the duty hours?"*';
        }
        return '';
      case AssistantLanguage.turkish:
        if (empty) return 'Tam anlayamadım, sorunuzu tekrar yazabilir misiniz?';
        if (fetchFailed) return 'Şu anda eczane listesine ulaşamadım. Lütfen tekrar deneyin.';
        if (noneOnDuty) return 'Şu anda listelenmiş nöbetçi eczane yok.';
        if (onDutyIntro) return 'Şu anda nöbetçi olan eczaneler:';
        if (moreCount != null) return '...ve $moreCount tane daha. Tümünü görmek için ana sayfadaki ilçe filtresini kullanın.';
        if (hours) {
          return 'Nöbetçi eczaneler genellikle normal eczanelerin kapalı olduğu saatleri kapsar — çoğunlukla gece '
              '(örn. 20:00–08:00). Her eczane kartında ve detay sayfasında tam saatler gösterilir.';
        }
        if (districts) {
          return 'Ana sayfadaki filtre çiplerini kullanarak ilçeye göre gözatabilirsiniz (Kadıköy, Beşiktaş, Şişli '
              've daha fazlası). Canlı liste için "hangi eczaneler nöbetçi" diye sorabilirsiniz.';
        }
        if (help) {
          return 'Nöbetçi eczaneler, açılış saatleri ve ilçeler hakkında yardımcı olabilirim. Örneğin '
              '*"şu anda hangi eczaneler nöbetçi?"* veya *"nöbet saatleri nedir?"* diye sorabilirsiniz.';
        }
        return '';
      case AssistantLanguage.arabic:
        if (empty) return 'لم أفهم ذلك تمامًا، هل يمكنك إعادة صياغة سؤالك؟';
        if (fetchFailed) return 'تعذر الوصول إلى قائمة الصيدليات الآن. حاول مرة أخرى.';
        if (noneOnDuty) return 'لا توجد صيدليات مناوبة مدرجة حاليًا.';
        if (onDutyIntro) return 'هذه هي الصيدليات المناوبة حاليًا:';
        if (moreCount != null) return '...و $moreCount أخرى. استخدم فلتر المنطقة في الصفحة الرئيسية لعرض الكل.';
        if (hours) {
          return 'تغطي الصيدليات المناوبة عادةً الساعات التي تكون فيها الصيدليات العادية مغلقة — غالبًا خلال الليل '
              '(مثلاً 20:00–08:00). تظهر الساعات الدقيقة في بطاقة كل صيدلية وصفحة تفاصيلها عند توفرها.';
        }
        if (districts) {
          return 'يمكنك التصفح حسب المنطقة باستخدام رقائق الفلتر في الصفحة الرئيسية (كاديكوي، بشيktاش، شيشلي، '
              'والمزيد). اسألني "ما هي الصيدليات المناوبة الآن" للحصول على قائمة مباشرة.';
        }
        if (help) {
          return 'يمكنني المساعدة بخصوص الصيدليات المناوبة وساعات العمل والمناطق. جرّب أن تسأل مثل '
              '*"ما هي الصيدليات المناوبة الآن؟"* أو *"ما هي ساعات المناوبة؟"*';
        }
        return '';
    }
  }
}
