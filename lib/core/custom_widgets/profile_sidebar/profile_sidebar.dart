import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/app_button/app_button.dart';
import 'package:portfolio/core/custom_widgets/circle_icon_button/circle_icon_button.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/custom_widgets/tag_chip/tag_chip.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/launcher.dart';
import 'package:portfolio/data/portfolio_data.dart';

/// Profile panel: pinned on wide screens, inside a Drawer on small ones.
class ProfileSidebar extends StatelessWidget {
  const ProfileSidebar({super.key});

  static const width = 320.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.stroke)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: _body()),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.stroke)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'CV',
                      icon: Icons.download_outlined,
                      onTap: () => openLink(PortfolioData.resumeUrl),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: 'Email me',
                      outlined: true,
                      onTap: () => openLink('mailto:${PortfolioData.email}'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      children: [
        Align(alignment: Alignment.centerRight, child: CircleIconButton.theme()),
        const Center(child: _Avatar()),
        const SizedBox(height: 14),
        Center(
          child: CustomText(
            text: PortfolioData.name,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Center(
          child: CustomText(text: PortfolioData.role, fontSize: 14, color: AppColors.textMuted),
        ),
        if (PortfolioData.openToWork) ...[
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(100)),
              child: CustomText(
                text: 'Open to Flutter roles',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentText,
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final s in PortfolioData.socials)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CircleIconButton(tooltip: s.label, icon: s.icon, onTap: () => openLink(s.url)),
              ),
          ],
        ),
        const SizedBox(height: 22),
        Divider(color: AppColors.stroke, height: 1),
        const SizedBox(height: 22),
        for (final (label, value) in PortfolioData.profileInfo) _InfoRow(label: label, value: value),
        const SizedBox(height: 14),
        CustomText(text: 'Core skills', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        const SizedBox(height: 14),
        for (final (name, level) in PortfolioData.coreSkills) _SkillBar(name: name, level: level),
        const SizedBox(height: 14),
        CustomText(text: 'Tools', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        const SizedBox(height: 12),
        Wrap(spacing: 6, runSpacing: 6, children: [for (final t in PortfolioData.tools) TagChip(label: t)]),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    // Swap the initials for Image.asset('assets/images/profile.webp') once a photo exists.
    return Stack(
      children: [
        Container(
          width: 88,
          height: 88,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceHigh,
            border: Border.all(color: AppColors.accent, width: 2),
          ),
          child: CustomText(
            text: PortfolioData.initials,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        if (PortfolioData.openToWork)
          Positioned(
            right: 3,
            bottom: 3,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 3),
              ),
            ),
          ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(6)),
            child: CustomText(text: label, fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onAccent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
              text: value,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final String name;
  final double level;

  const _SkillBar({required this.name, required this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(text: name, fontSize: 13, color: AppColors.textPrimary),
              const Spacer(),
              CustomText(text: '${(level * 100).round()}%', fontSize: 12, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 5,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: AppColors.stroke, borderRadius: BorderRadius.circular(100)),
            child: FractionallySizedBox(
              widthFactor: level,
              child: Container(
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
