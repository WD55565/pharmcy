import 'bootstrap.dart';
import 'core/config/app_config.dart';

/// Development entrypoint. Run with, e.g.:
///   flutter run -t lib/main_development.dart \
///     --dart-define=API_BASE_URL=http://10.0.2.2:8080/api
///
/// The default below targets the Android emulator's host-loopback address
/// for a locally running backend (see `backend/`); override it for a real
/// device, iOS simulator, or a different local setup.
void main() {
  bootstrap(
    const AppConfig(
      flavor: AppFlavor.development,
      apiBaseUrl: String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'http://10.0.2.2:8080/api',
      ),
    ),
  );
}
