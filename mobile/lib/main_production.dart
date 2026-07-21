import 'bootstrap.dart';
import 'core/config/app_config.dart';

/// Production entrypoint. Defaults to the deployed backend
/// (https://pharmcy-wx60.onrender.com) but can still be pointed at a
/// different deployment (e.g. staging) via --dart-define:
///   flutter build apk -t lib/main_production.dart \
///     --dart-define=API_BASE_URL=https://your-other-host/api
///   flutter build web -t lib/main_production.dart --release \
///     --dart-define=API_BASE_URL=https://your-other-host/api
const String _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://pharmcy-wx60.onrender.com/api',
);

void main() {
  // A plain `assert` would be stripped out of release builds entirely —
  // exactly the build mode this entrypoint is for — so an explicitly
  // blanked-out --dart-define (e.g. --dart-define=API_BASE_URL=) would
  // otherwise ship silently with an empty base URL instead of failing
  // loudly. This check must run unconditionally.
  if (_apiBaseUrl.isEmpty) {
    throw StateError(
      'API_BASE_URL must not be empty for production builds.',
    );
  }

  bootstrap(
    const AppConfig(flavor: AppFlavor.production, apiBaseUrl: _apiBaseUrl),
  );
}
