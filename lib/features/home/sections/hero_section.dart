import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/custom_widgets/section_wrapper/section_wrapper.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/data/portfolio_data.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = Responsive.isDesktop(context);

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name/status live in the sidebar; show them here only when it's hidden in the drawer.
        if (!Responsive.showSidebar(context)) ...[const _StatusRow(), const SizedBox(height: 24)],
        const _Headline(),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: CustomText(text: PortfolioData.tagline, fontSize: 16, height: 1.6, color: AppColors.textMuted),
        ),
      ],
    );

    final stats = [for (final h in PortfolioData.highlights) _Stat(value: h.$1, label: h.$2, stacked: wide)];

    return SectionWrapper(
      child: (wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: intro),
                    const SizedBox(width: 48),
                    SizedBox(
                      width: 220,
                      child: Column(
                        children: [
                          for (final (i, s) in stats.indexed) ...[if (i > 0) const SizedBox(height: 12), s],
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    intro,
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        for (final (i, s) in stats.indexed) ...[
                          if (i > 0) const SizedBox(width: 10),
                          Expanded(child: s),
                        ],
                      ],
                    ),
                  ],
                ))
          .animate()
          .fadeIn(duration: 600.ms)
          .slideY(begin: 0.04, end: 0, curve: Curves.easeOut),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: PortfolioData.name, fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: PortfolioData.openToWork ? AppColors.accent : AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            CustomText(
              text: PortfolioData.openToWork ? 'Open to Flutter roles' : PortfolioData.role,
              fontSize: 14,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ],
    );
  }
}

/// Stat card. [stacked] = desktop side column (value | label in a row);
/// otherwise an equal-width tile with value above label.
class _Stat extends StatelessWidget {
  final String value;
  final String label;
  final bool stacked;

  const _Stat({required this.value, required this.label, required this.stacked});

  @override
  Widget build(BuildContext context) {
    final valueText = CustomText(
      text: value,
      fontSize: stacked ? 28 : 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.8,
      color: AppColors.textPrimary,
    );
    final labelText = CustomText(text: label, fontSize: 13, color: AppColors.textMuted);

    return Container(
      width: double.infinity,
      padding: stacked ? const EdgeInsets.fromLTRB(20, 16, 20, 16) : const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: stacked
          ? Row(
              children: [
                valueText,
                const SizedBox(width: 12),
                Expanded(
                  child: CustomText(
                    text: label,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            )
          : Column(children: [valueText, const SizedBox(height: 2), labelText]),
    );
  }
}

/// Giant headline with one tilted accent-highlighted word.
class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    // CustomText scales up to 1.15x on wide screens.
    final size = Responsive.value<double>(context, mobile: 38, tablet: 50, desktop: 60);

    Widget word(String w, {Color? color}) => CustomText(
          text: w,
          fontSize: size,
          fontWeight: FontWeight.w700,
          height: 1.05,
          letterSpacing: -size * 0.035,
          color: color ?? AppColors.textPrimary,
        );

    return Wrap(
      spacing: size * 0.26,
      runSpacing: size * 0.12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final w in PortfolioData.headlineBefore.split(' ')) word(w),
        Transform.rotate(
          angle: -0.035,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size * 0.18, vertical: size * 0.04),
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(size * 0.22)),
            child: word(PortfolioData.headlineHighlight, color: AppColors.onAccent),
          ),
        ),
        for (final w in PortfolioData.headlineAfter.split(' ')) word(w),
      ],
    );
  }
}
