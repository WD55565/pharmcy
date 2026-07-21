/// Centralized route paths and names, so screens never hardcode a path
/// string when navigating.
abstract final class RoutePaths {
  static const String home = '/';
  static const String pharmacyDetail = '/pharmacy/:id';
  static const String onboarding = '/onboarding';
}

abstract final class RouteNames {
  static const String home = 'home';
  static const String pharmacyDetail = 'pharmacyDetail';
  static const String onboarding = 'onboarding';
}
