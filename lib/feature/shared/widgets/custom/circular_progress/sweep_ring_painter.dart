import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class SweepRingPainter extends CustomPainter {
  final double thickness;
  final List<Color> colors;

  SweepRingPainter({
    required this.thickness, 
    required this.colors
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final sweep = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 6.28318,
        colors: colors,
        stops: [0.0, 0.55, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final background = Paint()
      ..color = AppColors.infoBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - thickness) / 2;

    // anillo suave de fondo
    canvas.drawCircle(
      center, radius, background
    );
    // anillo degradado (spinner)
    canvas.drawArc(
      Rect.fromCircle(
        center: center, 
        radius: radius
      ),
      0,
      6.28318, // círculo completo; el degradado da el efecto de “arco”
      false,
      sweep,
    );
  }

  @override
  bool shouldRepaint(covariant SweepRingPainter oldDelegate) {
    return oldDelegate.thickness != thickness || oldDelegate.colors != colors;
    }
}