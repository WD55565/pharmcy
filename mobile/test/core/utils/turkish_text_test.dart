import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/utils/turkish_text.dart';

void main() {
  group('normalizeTurkish', () {
    test('lowercases Turkish İ to dotted i', () {
      expect(normalizeTurkish('İstanbul'), 'istanbul');
    });

    test('lowercases Turkish I to dotless ı, not i', () {
      expect(normalizeTurkish('KADIKÖY'), 'kadıköy');
    });

    test('leaves already-lowercase Turkish text unchanged', () {
      expect(normalizeTurkish('kadıköy eczanesi'), 'kadıköy eczanesi');
    });

    test('applies Turkish I->ı casing even within otherwise-ASCII text', () {
      expect(normalizeTurkish('MERKEZ ECZANESI'), 'merkez eczanesı');
    });

    test('search query and stored value normalize to the same form', () {
      // A user typing a dotless "ı" and the backend's ALL-CAPS "I" must
      // converge to the same normalized string for `contains` to match.
      final query = normalizeTurkish('kadıköy');
      final stored = normalizeTurkish('KADIKÖY ECZANESİ');
      expect(stored.contains(query), isTrue);
    });
  });
}
