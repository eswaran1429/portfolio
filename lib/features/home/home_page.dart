import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/profile_sidebar/profile_sidebar.dart';
import 'package:portfolio/core/custom_widgets/top_bar/top_bar.dart';
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
    final pinned = Responsive.showSidebar(context);
    const content = SingleChildScrollView(
      child: Column(children: [HeroSection(), WorkSection(), ServicesSection(), ExperienceSection(), Footer()]),
    );

    return Scaffold(
      drawer: pinned ? null : const Drawer(width: ProfileSidebar.width, child: ProfileSidebar()),
      body: pinned
          ? const Row(children: [ProfileSidebar(), Expanded(child: content)])
          : const Column(children: [TopBar(), Expanded(child: content)]),
    );
  }
}
