import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/custom_widgets/section_title/section_title.dart';
import 'package:portfolio/core/custom_widgets/section_wrapper/section_wrapper.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/models.dart';
import 'package:portfolio/data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = PortfolioData.experience;

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'Experience', title: 'Where I have worked'),
          for (final (i, e) in items.indexed) _TimelineTile(item: e, isLast: i == items.length - 1),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final Experience item;
  final bool isLast;

  const _TimelineTile({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                  border: Border.all(color: AppColors.accentSoft, width: 3),
                ),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: AppColors.stroke)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: item.period, fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accentText),
                  const SizedBox(height: 4),
                  CustomText(text: item.role, fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  CustomText(text: item.company, fontSize: 14, color: AppColors.textMuted),
                  const SizedBox(height: 10),
                  for (final point in item.points)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: CustomText(text: '•  $point', fontSize: 14, height: 1.6, color: AppColors.textMuted),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
