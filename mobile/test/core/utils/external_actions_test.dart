import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/utils/external_actions.dart';

void main() {
  group('buildMapsUri', () {
    test('uses Google Maps search with coordinates on Android', () {
      final uri = buildMapsUri(
        latitude: 40.99,
        longitude: 29.03,
        fallbackQuery: 'ignored',
        platform: TargetPlatform.android,
      );

      expect(
        uri.toString(),
        'https://www.google.com/maps/search/?api=1&query=40.99,29.03',
      );
    });

    test(
      'uses Google Maps text search when coordinates are missing on Android',
      () {
        final uri = buildMapsUri(
          fallbackQuery: 'Bağdat Caddesi No:1, Kadıköy',
          platform: TargetPlatform.android,
        );

        expect(uri.host, 'www.google.com');
        expect(uri.queryParameters['query'], 'Bağdat Caddesi No:1, Kadıköy');
      },
    );

    test('uses Apple Maps with coordinates on iOS', () {
      final uri = buildMapsUri(
        latitude: 40.99,
        longitude: 29.03,
        fallbackQuery: 'Merkez Eczanesi',
        platform: TargetPlatform.iOS,
      );

      expect(uri.host, 'maps.apple.com');
      expect(uri.queryParameters['ll'], '40.99,29.03');
      expect(uri.queryParameters['q'], 'Merkez Eczanesi');
    });

    test('uses Apple Maps text search when coordinates are missing on iOS', () {
      final uri = buildMapsUri(
        fallbackQuery: 'Merkez Eczanesi, Kadıköy',
        platform: TargetPlatform.iOS,
      );

      expect(uri.host, 'maps.apple.com');
      expect(uri.queryParameters.containsKey('ll'), isFalse);
      expect(uri.queryParameters['q'], 'Merkez Eczanesi, Kadıköy');
    });

    test('uses Apple Maps on macOS too', () {
      final uri = buildMapsUri(
        fallbackQuery: 'Merkez Eczanesi',
        platform: TargetPlatform.macOS,
      );

      expect(uri.host, 'maps.apple.com');
    });

    test(
      'falls back to Google Maps on other platforms (web, windows, linux)',
      () {
        for (final platform in [
          TargetPlatform.windows,
          TargetPlatform.linux,
          TargetPlatform.fuchsia,
        ]) {
          final uri = buildMapsUri(
            fallbackQuery: 'Merkez Eczanesi',
            platform: platform,
          );
          expect(uri.host, 'www.google.com', reason: 'platform: $platform');
        }
      },
    );
  });
}
