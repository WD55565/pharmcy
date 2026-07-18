import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Build flavor the app was launched with. Selected by the entrypoint used
/// (`main_development.dart` / `main_production.dart`), never inferred at
/// runtime.
enum AppFlavor { development, production }

/// Immutable, environment-specific configuration. One instance is created by
/// the chosen entrypoint and injected into the widget tree via
/// [appConfigProvider] — nothing in `core` or `features` reads environment
/// variables or flavor state directly.
class AppConfig {
  const AppConfig({required this.flavor, required this.apiBaseUrl});

  final AppFlavor flavor;
  final String apiBaseUrl;

  bool get isProduction => flavor == AppFlavor.production;
  bool get isDevelopment => flavor == AppFlavor.development;
}

/// Overridden with the real [AppConfig] in `bootstrap()`. Reading this
/// before the override is applied is a programming error and throws
/// intentionally.
final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError(
    'appConfigProvider was not overridden. Launch the app through '
    'bootstrap() with a concrete AppConfig.',
  );
});
