import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/custom_widgets/section_title/section_title.dart';
import 'package:portfolio/core/custom_widgets/section_wrapper/section_wrapper.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/data/models.dart';
import 'package:portfolio/data/portfolio_data.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 4);
    final services = PortfolioData.services;
    const gap = 16.0;

    // Rows of [columns] cards; each row's cards share the tallest card's height.
    final rows = <Widget>[
      for (var start = 0; start < services.length; start += columns)
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = start; i < start + columns; i++) ...[
                if (i > start) const SizedBox(width: gap),
                Expanded(child: i < services.length ? _ServiceCard(service: services[i]) : const SizedBox()),
              ],
            ],
          ),
        ),
    ];

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'What I do', title: 'From first screen to store release'),
          for (final (i, row) in rows.indexed) ...[if (i > 0) const SizedBox(height: gap), row],
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Service service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: AppColors.accentSoft, shape: BoxShape.circle),
            child: Icon(service.icon, size: 22, color: AppColors.accentText),
          ),
          const SizedBox(height: 16),
          CustomText(text: service.title, fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          const SizedBox(height: 8),
          CustomText(text: service.description, fontSize: 13, height: 1.6, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
