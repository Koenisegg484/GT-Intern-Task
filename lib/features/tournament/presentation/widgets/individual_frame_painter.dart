import 'package:flutter/material.dart';

class IndividualFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    final path = Path()
      ..moveTo(size.width * 0.47, size.height * 0.06)
      ..lineTo(size.width * 0.09, size.height * 0.225)
      ..lineTo(size.width * 0.17, size.height * 0.7904714)
      ..lineTo(size.width * 0.48, size.height * 0.99)
      ..lineTo(size.width * 0.78, size.height * 0.8)
      ..lineTo(size.width * 0.85, size.height * 0.225)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
