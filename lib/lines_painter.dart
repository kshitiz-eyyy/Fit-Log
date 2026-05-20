import 'package:flutter/material.dart';

class DiagonalLinesPainter extends CustomPainter {
  final Color lineColor;

  DiagonalLinesPainter({required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final pathLeft = Path()
      ..moveTo(0, size.height * 0.45)
      ..lineTo(size.width * 0.45, size.height * 0.68)
      ..lineTo(size.width, size.height * 0.35);

    final pathRight = Path()
      ..moveTo(size.width, size.height * 0.45)
      ..lineTo(size.width * 0.55, size.height * 0.68)
      ..lineTo(0, size.height * 0.35);

    canvas.drawPath(pathLeft, paint);
    canvas.drawPath(pathRight, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}