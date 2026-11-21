import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';

enum DoodleShape { plus, circles, zigzag, play }

/// Small outline decoration shapes scattered around hero visuals.
class Doodle extends StatelessWidget {
  final DoodleShape shape;
  final double size;
  final Color? color;

  const Doodle(this.shape, {super.key, this.size = 28, this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _DoodlePainter(shape, color ?? AppColors.textMuted.withValues(alpha: 0.6)),
    );
  }
}

class _DoodlePainter extends CustomPainter {
  final DoodleShape shape;
  final Color color;

  _DoodlePainter(this.shape, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    switch (shape) {
      case DoodleShape.plus:
        canvas.drawLine(Offset(s / 2, s * 0.15), Offset(s / 2, s * 0.85), paint);
        canvas.drawLine(Offset(s * 0.15, s / 2), Offset(s * 0.85, s / 2), paint);
      case DoodleShape.circles:
        canvas.drawCircle(Offset(s * 0.4, s * 0.4), s * 0.3, paint);
        canvas.drawCircle(Offset(s * 0.6, s * 0.6), s * 0.3, paint);
      case DoodleShape.zigzag:
        final path = Path()..moveTo(0, s * 0.65);
        const peaks = 4;
        for (var i = 1; i <= peaks * 2; i++) {
          path.lineTo(s * i / (peaks * 2), i.isOdd ? s * 0.35 : s * 0.65);
        }
        canvas.drawPath(path, paint);
      case DoodleShape.play:
        Path tri(double dx, double dy) => Path()
          ..moveTo(s * 0.2 + dx, s * 0.15 + dy)
          ..lineTo(s * 0.85 + dx, s * 0.5 + dy)
          ..lineTo(s * 0.2 + dx, s * 0.85 + dy)
          ..close();
        canvas.drawPath(tri(0, 0), paint);
        canvas.save();
        canvas.translate(s * 0.12, s * 0.1);
        canvas.rotate(math.pi / 60);
        canvas.drawPath(tri(0, 0), paint..color = color.withValues(alpha: color.a * 0.5));
        canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_DoodlePainter old) => old.shape != shape || old.color != color;
}
