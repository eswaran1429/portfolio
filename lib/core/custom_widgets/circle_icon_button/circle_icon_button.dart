import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_theme.dart';

class CircleIconButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({super.key, required this.tooltip, required this.icon, required this.onTap});

  /// Light/dark toggle.
  factory CircleIconButton.theme() => CircleIconButton(
        tooltip: 'Toggle theme',
        icon: AppColors.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        onTap: AppTheme.toggle,
      );

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        shape: CircleBorder(side: BorderSide(color: AppColors.stroke)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(width: 44, height: 44, child: Icon(icon, size: 20, color: AppColors.textPrimary)),
        ),
      ),
    );
  }
}
