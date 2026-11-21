import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class AppTheme {
  static final themeMode = ValueNotifier<ThemeMode>(ThemeMode.dark);

  static void toggle() {
    themeMode.value = themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    // AppColors getters are static, so widgets don't depend on Theme. Mark every
    // element dirty so they re-read colors (keeps scroll + route state).
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    WidgetsBinding.instance.rootElement?.visitChildren(rebuild);
  }

  /// Builds theme from current [AppColors.isDark]. Set that flag before calling.
  static ThemeData build() {
    final brightness = AppColors.isDark ? Brightness.dark : Brightness.light;
    return ThemeData(
      brightness: brightness,
      fontFamily: CustomText.fontFamily,
      scaffoldBackgroundColor: AppColors.bg,
      dividerColor: AppColors.stroke,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent, brightness: brightness).copyWith(
        primary: AppColors.accentText,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.accentText),
    );
  }
}
