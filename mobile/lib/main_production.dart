import 'bootstrap.dart';
import 'core/config/app_config.dart';

/// Production entrypoint. The backend URL is required at build time and is
/// never hardcoded or defaulted:
///   flutter build apk -t lib/main_production.dart \
///     --dart-define=API_BASE_URL=https://your-production-host/api
///   flutter build web -t lib/main_production.dart --release \
///     --dart-define=API_BASE_URL=https://your-production-host/api
const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

void main() {
  // A plain `assert` would be stripped out of release builds entirely —
  // exactly the build mode this entrypoint is for — so a missing
  // --dart-define would otherwise ship silently with an empty base URL
  // instead of failing loudly. This check must run unconditionally.
  if (_apiBaseUrl.isEmpty) {
    throw StateError(
      'API_BASE_URL must be supplied via --dart-define for production builds.',
    );
  }

  bootstrap(
    const AppConfig(flavor: AppFlavor.production, apiBaseUrl: _apiBaseUrl),
  );
}
