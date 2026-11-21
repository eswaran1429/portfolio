import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/portfolio_data.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: CustomText(
        text: '© ${DateTime.now().year} ${PortfolioData.name} · Built with Flutter',
        textAlign: TextAlign.center,
        fontSize: 12,
        color: AppColors.textMuted,
      ),
    );
  }
}
