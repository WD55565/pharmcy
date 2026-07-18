import 'main_development.dart' as development;

/// Default entrypoint for plain `flutter run` during local development.
/// CI/CD and release builds should target `main_development.dart` /
/// `main_production.dart` explicitly instead.
void main() {
  development.main();
}
