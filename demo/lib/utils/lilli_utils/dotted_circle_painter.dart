import 'dart:math';
import 'package:flutter/material.dart';

class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    const int totalDots = 40;
    const double dotLength = 8.0;

    double angleStep = 2 * pi / totalDots;

    for (int i = 0; i < totalDots; i++) {
      paint.color = i % 2 == 0 ? const Color(0xFFFFCB59) : Colors.white;

      double startAngle = i * angleStep;
      double endAngle = startAngle + (dotLength / radius);

      Offset start = Offset(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );

      Offset end = Offset(
        center.dx + radius * cos(endAngle),
        center.dy + radius * sin(endAngle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
