import 'package:flutter/material.dart';
import 'dart:math';

class Circle2LinePainter extends CustomPainter {
  double radius;
  double lineNum;
  double progress;
  Circle2LinePainter({
    this.radius = 50,
    this.lineNum = 20,
    this.progress = 0.0,
  });
  double get lineLength => 2 * pi * radius / lineNum;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF2C343A)
      ..strokeWidth = 4;
    canvas.translate(size.width / 2, size.height / 2);
    Offset p1 = const Offset(0, 0);
    Offset p2 = Offset(lineLength - 4, 0);
    for (int i = 0; i < lineNum; i++) {
      canvas.drawLine(p1, p2, paint);
      canvas.translate(p2.dx + 4, p2.dy);
      canvas.rotate((progress / 20.0) * 2 * pi / lineNum);
    }
  }

  @override
  bool shouldRepaint(Circle2LinePainter oldDelegate) {
    return true;
  }
}
