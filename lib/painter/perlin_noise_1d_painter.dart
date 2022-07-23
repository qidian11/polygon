import 'package:flutter/material.dart';
import 'package:polygon/noise/index.dart';
import 'dart:math';

class PerlinNoise1dPainter extends CustomPainter {
  double progress;
  double maxProgress;
  double scale;
  PerlinNoise1dPainter(
      {this.progress = 0, this.maxProgress = 20, this.scale = 50});
  double get rotation => progress / maxProgress * 2 * pi;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = const Color(0xFF2C343A)
      ..strokeWidth = 1.0;
    double x, y;
    for (int i = 0; i < 200; i++) {
      x = i - 100;

      // print('progress:$progress,this rotation:$rotation');
      double value =
          PerlinNoise.getD1PerlinNoise(i * 0.02, 0, rotation: rotation);
      value += 1;
      value /= 2;
      y = value * scale;
      // paint.color = Color(0xFF000000);
      canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
    }
  }

  @override
  bool shouldRepaint(PerlinNoise1dPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
