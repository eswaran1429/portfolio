import 'package:flutter/widgets.dart';

class Responsive {
  static const double mobileMax = 600;
  static const double tabletMax = 1024;
  static const double contentMaxWidth = 1100;

  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < mobileMax;
  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= tabletMax;

  /// Profile sidebar stays pinned at this width and up; below it lives in a drawer.
  static const double sidebarMin = 1200;
  static bool showSidebar(BuildContext context) => MediaQuery.sizeOf(context).width >= sidebarMin;

  /// Pick a value by screen size. [tablet] falls back to [desktop].
  static T value<T>(BuildContext context, {required T mobile, T? tablet, required T desktop}) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobileMax) return mobile;
    if (width < tabletMax) return tablet ?? desktop;
    return desktop;
  }
}
