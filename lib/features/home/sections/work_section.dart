import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/section_title/section_title.dart';
import 'package:portfolio/core/custom_widgets/section_wrapper/section_wrapper.dart';
import 'package:portfolio/features/home/widgets/project_showcase.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(eyebrow: 'Work', title: 'Apps in production'),
          ProjectShowcase(),
        ],
      ),
    );
  }
}
