import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';

/// Accent eyebrow + large title.
class SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;

  const SectionTitle({super.key, required this.eyebrow, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 24, height: 2, color: AppColors.accentText),
              const SizedBox(width: 10),
              CustomText(
                text: eyebrow.toUpperCase(),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: AppColors.accentText,
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomText(
            text: title,
            fontSize: Responsive.value(context, mobile: 28, desktop: 38),
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
            height: 1.1,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
