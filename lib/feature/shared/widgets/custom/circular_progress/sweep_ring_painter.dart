import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class SweepRingPainter extends CustomPainter {
  final double thickness;
  final List<Color> colors;
  final List<double>? stops;

  SweepRingPainter({
    required this.thickness,
    required this.colors,
    this.stops,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - thickness) / 2;
    final arcRect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..color = AppColors.infoBackground.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final sweep = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 6.28318,
        colors: colors,
        stops: stops,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);
    canvas.drawArc(arcRect, 0, 5.2, false, sweep);
  }

  @override
  bool shouldRepaint(covariant SweepRingPainter oldDelegate) {
    return oldDelegate.thickness != thickness ||
        oldDelegate.colors != colors ||
        oldDelegate.stops != stops;
  }
}
