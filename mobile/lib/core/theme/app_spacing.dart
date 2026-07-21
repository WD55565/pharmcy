/// Spacing scale used throughout the app instead of ad-hoc pixel values,
/// so paddings/gaps stay visually consistent as screens are added.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// Standard animation durations/curves, kept short and consistent so
/// transitions read as "snappy" rather than sluggish.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
}
