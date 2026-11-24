import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_theme.dart';

class CircleIconButton extends StatelessWidget {
  final String tooltip;
  final IconData? icon;
  final VoidCallback onTap;

  /// Custom content (e.g. a logo image) shown instead of [icon].
  final Widget? child;

  const CircleIconButton({super.key, required this.tooltip, this.icon, this.child, required this.onTap})
    : assert(icon != null || child != null);

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
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(child: child ?? Icon(icon, size: 20, color: AppColors.textPrimary)),
          ),
        ),
      ),
    );
  }
}
