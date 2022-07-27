import 'package:flutter/cupertino.dart';
import 'package:polygon/noise/index.dart';
import 'dart:math';

class PerlinNoise2dPainter extends CustomPainter {
  double progress;
  double maxProgress;
  PerlinNoise2dPainter({this.progress = 0, this.maxProgress = 20});
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
      for (int j = 0; j < 200; j++) {
        y = j - 100;
        // print('progress:$progress,this rotation:$rotation');
        double value = PerlinNoise.getD2PerlinNoise(i * 0.02, j * 0.02,
            rotation: rotation);
        value += 1;
        value /= 2;
        int color = (value * 255).round();
        if (color > 200) {
          color = 0;
          paint.color = Color.fromARGB(255, color, color, color);
          // paint.color = Color(0xFF000000);
          canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
        } else if (color > 128) {
          color = 255;
        } else {
          color = 0;
          paint.color = Color.fromARGB(255, color, color, color);
          // paint.color = Color(0xFF000000);
          canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(PerlinNoise2dPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
