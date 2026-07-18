import 'package:flutter/widgets.dart';

/// Width breakpoints used consistently across the app instead of ad-hoc
/// magic numbers in individual screens.
abstract final class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
}

enum ScreenSize { mobile, tablet, desktop }

extension ScreenSizeContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  ScreenSize get screenSize {
    final width = screenWidth;
    if (width >= Breakpoints.tablet) return ScreenSize.desktop;
    if (width >= Breakpoints.mobile) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  bool get isMobile => screenSize == ScreenSize.mobile;
  bool get isTablet => screenSize == ScreenSize.tablet;
  bool get isDesktop => screenSize == ScreenSize.desktop;
}

/// Picks one of three builders based on the current [ScreenSize], falling
/// back progressively (desktop -> tablet -> mobile) when a size-specific
/// builder isn't provided.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    switch (context.screenSize) {
      case ScreenSize.desktop:
        return (desktop ?? tablet ?? mobile)(context);
      case ScreenSize.tablet:
        return (tablet ?? mobile)(context);
      case ScreenSize.mobile:
        return mobile(context);
    }
  }
}
