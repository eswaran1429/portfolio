import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/profile_sidebar/profile_sidebar.dart';
import 'package:portfolio/core/custom_widgets/section_title/section_title.dart';
import 'package:portfolio/core/custom_widgets/section_wrapper/section_wrapper.dart';
import 'package:portfolio/core/custom_widgets/top_bar/top_bar.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/features/home/sections/experience_section.dart';
import 'package:portfolio/features/home/sections/footer.dart';
import 'package:portfolio/features/home/sections/hero_section.dart';
import 'package:portfolio/features/home/sections/services_section.dart';
import 'package:portfolio/features/home/sections/work_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.showSidebar(context)) {
      return const Scaffold(
        body: Row(
          children: [
            ProfileSidebar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeroSection(),
                    WorkSection(),
                    ServicesSection(),
                    ExperienceSection(),
                    Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Narrow screens: sidebar content inline — profile on top, details as a section, contact pinned at bottom.
    // Top bar scrolls away with the content.
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            _ProfileCard(),
            HeroSection(),
            WorkSection(),
            ServicesSection(),
            _ProfileDetailsSection(),
            ExperienceSection(),
            Footer(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.stroke)),
        ),
        child: const SafeArea(
          top: false,
          child: Padding(padding: EdgeInsets.fromLTRB(16, 12, 16, 12), child: ContactButtons()),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.stroke),
        ),
        child: const ProfileHeader(),
      ),
    );
  }
}

class _ProfileDetailsSection extends StatelessWidget {
  const _ProfileDetailsSection();

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'Profile', title: 'Education'),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.stroke),
            ),
            child: const ProfileDetails(),
          ),
        ],
      ),
    );
  }
}
