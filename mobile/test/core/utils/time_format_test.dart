import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/utils/time_format.dart';

void main() {
  group('formatDutyTime', () {
    test('trims seconds from an HH:mm:ss backend string', () {
      expect(formatDutyTime('09:00:00'), '09:00');
      expect(formatDutyTime('19:30:45'), '19:30');
    });

    test('returns null unchanged', () {
      expect(formatDutyTime(null), isNull);
    });

    test('returns short/malformed input unchanged rather than throwing', () {
      expect(formatDutyTime(''), '');
      expect(formatDutyTime('9'), '9');
    });
  });
}
