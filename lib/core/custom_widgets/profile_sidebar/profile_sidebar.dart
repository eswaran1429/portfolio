import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/app_button/app_button.dart';
import 'package:portfolio/core/custom_widgets/circle_icon_button/circle_icon_button.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/launcher.dart';
import 'package:portfolio/data/portfolio_data.dart';

/// Profile panel pinned on wide screens. On phones its parts are laid out inline instead
/// (see HomePage): [ProfileHeader] on top, [ProfileDetails] as a section, [ContactButtons] pinned at bottom.
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  Align(alignment: Alignment.centerRight, child: CircleIconButton.theme()),
                  const ProfileHeader(),
                  const SizedBox(height: 22),
                  Divider(color: AppColors.stroke, height: 1),
                  const SizedBox(height: 22),
                  const ProfileDetails(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.stroke)),
              ),
              child: const ContactButtons(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Avatar, name, role, availability badge, socials — centered.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Avatar(),
        const SizedBox(height: 14),
        CustomText(text: PortfolioData.name, fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        const SizedBox(height: 2),
        CustomText(text: PortfolioData.role, fontSize: 14, color: AppColors.textMuted),
        if (PortfolioData.openToWork) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(100)),
            child: CustomText(
              text: 'Open to Flutter roles',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.accentText,
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
                child: CircleIconButton(
                  tooltip: s.label,
                  icon: s.icon,
                  onTap: () => openLink(s.url),
                  child: s.asset == null
                      ? null
                      : Image.asset(
                          s.asset!,
                          width: 20,
                          height: 20,
                          color: s.tintAsset ? AppColors.textPrimary : null,
                          colorBlendMode: s.tintAsset ? BlendMode.srcIn : null,
                        ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Info rows (residence, education).
class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [for (final (label, value) in PortfolioData.profileInfo) _InfoRow(label: label, value: value)],
    );
  }
}

/// CV + Email me, side by side.
class ContactButtons extends StatelessWidget {
  const ContactButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(label: 'CV', icon: Icons.download_outlined, onTap: () => openLink(PortfolioData.resumeUrl)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(label: 'Email me', outlined: true, onTap: () => openLink('mailto:${PortfolioData.email}')),
        ),
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
