import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/responsive.dart';

/// Centers content at max width and applies responsive page padding.
class SectionWrapper extends StatelessWidget {
  final Widget child;

  const SectionWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.value<double>(context, mobile: 16, tablet: 32, desktop: 48);
    final vPad = Responsive.value<double>(context, mobile: 32, desktop: 48);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.contentMaxWidth),
          child: child,
        ),
      ),
    );
  }
}
