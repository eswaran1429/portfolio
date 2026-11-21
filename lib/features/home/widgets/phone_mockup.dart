import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/models.dart';

/// Phone frame showing [Project.image], or a skeleton app screen when null.
class PhoneMockup extends StatelessWidget {
  final Project project;
  final double width;

  const PhoneMockup({super.key, required this.project, required this.width});

  static const aspect = 2.05; // height / width

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * aspect,
      padding: EdgeInsets.all(width * 0.035),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0B),
        borderRadius: BorderRadius.circular(width * 0.16),
        border: Border.all(color: const Color(0xFF3A3A3F), width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 40, offset: const Offset(0, 20))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.13),
        child: Stack(
          children: [
            Positioned.fill(
              child: project.image != null
                  ? Image.asset(project.image!, fit: BoxFit.cover)
                  : _SkeletonScreen(title: project.title, width: width),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: width * 0.04),
                width: width * 0.3,
                height: width * 0.075,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonScreen extends StatelessWidget {
  final String title;
  final double width;

  const _SkeletonScreen({required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    final u = width / 100; // layout unit
    Widget bar(double w, {Color color = const Color(0xFFE4E4DD), double h = 3}) => Container(
          width: w * u,
          height: h * u,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
        );

    return Container(
      color: const Color(0xFFF7F7F2),
      padding: EdgeInsets.fromLTRB(7 * u, 18 * u, 7 * u, 7 * u),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9 * u,
                height: 9 * u,
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(3 * u)),
              ),
              SizedBox(width: 3 * u),
              bar(30),
              const Spacer(),
              Container(
                width: 9 * u,
                height: 9 * u,
                decoration: const BoxDecoration(color: Color(0xFFE4E4DD), shape: BoxShape.circle),
              ),
            ],
          ),
          SizedBox(height: 8 * u),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(6 * u),
            decoration: BoxDecoration(color: const Color(0xFF0A0A0B), borderRadius: BorderRadius.circular(6 * u)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bar(18, color: AppColors.accent, h: 4),
                SizedBox(height: 4 * u),
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: CustomText.fontFamily,
                    fontSize: 7.5 * u,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4 * u),
                bar(50, color: const Color(0xFF3A3A3F)),
              ],
            ),
          ),
          SizedBox(height: 7 * u),
          for (var i = 0; i < 4; i++) ...[
            Row(
              children: [
                Container(
                  width: 11 * u,
                  height: 11 * u,
                  decoration: BoxDecoration(color: const Color(0xFFE4E4DD), borderRadius: BorderRadius.circular(3 * u)),
                ),
                SizedBox(width: 4 * u),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [bar(40.0 - i * 5), SizedBox(height: 2 * u), bar(26)],
                ),
              ],
            ),
            SizedBox(height: 5 * u),
          ],
          const Spacer(),
          Container(
            width: double.infinity,
            height: 13 * u,
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(100)),
          ),
        ],
      ),
    );
  }
}
