import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/circle_icon_button/circle_icon_button.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/portfolio_data.dart';

/// Small-screen header: profile button (opens sidebar drawer), logo, theme toggle.
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.stroke),
          ),
          child: Row(
            children: [
              Tooltip(
                message: 'Profile',
                child: InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceHigh,
                      border: Border.all(color: AppColors.accent, width: 1.5),
                    ),
                    child: CustomText(
                      text: PortfolioData.initials,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              CustomText(
                text: PortfolioData.firstName.toLowerCase(),
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: AppColors.textPrimary,
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(6)),
                child: const CustomText(text: '.dev', fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.onAccent),
              ),
              const Spacer(),
              CircleIconButton.theme(),
            ],
          ),
        ),
      ),
    );
  }
}
