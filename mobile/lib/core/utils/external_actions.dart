import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Thin wrappers around `url_launcher` / `share_plus` so feature code
/// depends on these named functions rather than the packages directly.
/// Each returns whether the action was actually launched, letting callers
/// show their own feedback (e.g. a snackbar) on failure.

Future<bool> launchPhoneCall(String phoneNumber) {
  final sanitized = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
  return _launch(Uri(scheme: 'tel', path: sanitized));
}

/// Opens the device's default maps app: Apple Maps on iOS/macOS, Google
/// Maps everywhere else. Uses [latitude]/[longitude] when available for a
/// precise pin; otherwise falls back to a text search on [fallbackQuery]
/// (e.g. the pharmacy's address). Neither URL scheme requires an API key or
/// any app permission — both are plain web links resolved by the OS.
Future<bool> launchMaps({
  double? latitude,
  double? longitude,
  required String fallbackQuery,
}) {
  final uri = buildMapsUri(
    latitude: latitude,
    longitude: longitude,
    fallbackQuery: fallbackQuery,
    platform: defaultTargetPlatform,
  );
  return _launch(uri);
}

/// Pure URL-building logic, split out from [launchMaps] so it can be unit
/// tested without touching `url_launcher`'s platform channel.
@visibleForTesting
Uri buildMapsUri({
  double? latitude,
  double? longitude,
  required String fallbackQuery,
  required TargetPlatform platform,
}) {
  final hasCoordinates = latitude != null && longitude != null;
  final isApplePlatform =
      platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

  if (isApplePlatform) {
    return hasCoordinates
        ? Uri.parse(
            'https://maps.apple.com/?ll=$latitude,$longitude&q=${Uri.encodeComponent(fallbackQuery)}',
          )
        : Uri.parse(
            'https://maps.apple.com/?q=${Uri.encodeComponent(fallbackQuery)}',
          );
  }

  return hasCoordinates
      ? Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
        )
      : Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(fallbackQuery)}',
        );
}

Future<bool> _launch(Uri uri) async {
  if (!await canLaunchUrl(uri)) return false;
  return launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<ShareResult> shareText(String text, {String? subject}) {
  return SharePlus.instance.share(ShareParams(text: text, subject: subject));
}
