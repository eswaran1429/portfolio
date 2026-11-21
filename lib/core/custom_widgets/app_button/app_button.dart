import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/theme/app_colors.dart';

/// Pill button. Filled variant shows [icon] inside an accent circle.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool outlined;

  /// Use when the button sits on an accent-colored surface.
  final bool onAccentSurface;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.outlined = false,
    this.onAccentSurface = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color fill;
    final Color fg;
    final Color border;
    if (onAccentSurface) {
      fill = outlined ? Colors.transparent : AppColors.onAccent;
      fg = outlined ? AppColors.onAccent : Colors.white;
      border = AppColors.onAccent.withValues(alpha: 0.35);
    } else {
      fill = outlined ? Colors.transparent : AppColors.textPrimary;
      fg = outlined ? AppColors.textPrimary : AppColors.onInverse;
      border = AppColors.stroke;
    }
    final circleIcon = icon != null && !outlined;

    return SizedBox(
      height: 52,
      child: Material(
        color: fill,
        clipBehavior: Clip.antiAlias,
        shape: StadiumBorder(side: outlined ? BorderSide(color: border, width: 1.5) : BorderSide.none),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: circleIcon ? 6 : 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CustomText(
                    text: label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: fg,
                  ),
                ),
                if (icon != null) ...[
                  SizedBox(width: circleIcon ? 14 : 8),
                  if (circleIcon)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                      child: Icon(icon, size: 20, color: AppColors.onAccent),
                    )
                  else
                    Icon(icon, size: 18, color: fg),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
