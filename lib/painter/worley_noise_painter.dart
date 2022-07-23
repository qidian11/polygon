import 'package:flutter/material.dart';
import 'package:polygon/noise/index.dart';
import 'my_painter.dart';
import 'dart:math';

class WorleyNoisePainter extends CustomPainter {
  double progress;
  double maxProgress;
  WorleyNoisePainter({this.progress = 0, this.maxProgress = 0});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    canvas.translate(size.width / 2, size.height / 2);
    for (int i = 0; i < 200; i++) {
      int x = i - 100;
      for (int j = 0; j < 200; j++) {
        int y = j - 100;
        double value = WorleyNoise.getWorleyNoise(i * 0.05, y * 0.05);
        int colorValue = (value * 255).round();
        Color color = Color.fromARGB(255, colorValue, colorValue, colorValue);
        paint.color = color;
        canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(WorleyNoisePainter oldDelegate) {
    return true;
  }
}
