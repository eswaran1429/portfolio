import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/features/home/home_page.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.themeMode,
      builder: (context, mode, _) {
        AppColors.isDark = mode == ThemeMode.dark;
        return MaterialApp(
          title: '${PortfolioData.name} · ${PortfolioData.role}',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.build(),
          home: const HomePage(),
        );
      },
    );
  }
}
