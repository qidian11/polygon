import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:polygon/util/moon_util.dart';
import 'package:polygon/util/extension_util.dart';
import 'package:polygon/noise/vector3.dart';

class MoonPainter extends CustomPainter {
  double progress;
  double maxProgress;
  double radius;
  bool update;
  Vector3 ray = Vector3(1, 1, 0);
  MoonPainter(
      {this.progress = 0,
      this.maxProgress = 2 * pi,
      this.radius = 150,
      this.update = true});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint();
    double x, y, z;
    for (int i = 0; i < 2 * radius; i++) {
      x = i - radius;
      double pRadiusX;
      for (int j = 0; j < 2 * radius; j++) {
        y = j - radius;
        if (x * x + y * y > radius * radius) {
          continue;
        }
        z = sqrt(radius * radius - (x * x + y * y));
        Vector3 v = Vector3(x, y, z);
        double dotValue = v.dot(ray);
        double brightness = -dotValue / (v.length * ray.length) - 0.5;

        if (y == radius || y == -radius) {
          pRadiusX = radius;
        } else {
          pRadiusX = sqrt(radius * radius - y * y);
        }

        double cosAngleI = x / pRadiusX;
        double angleI = acos(cosAngleI);

        int imageX = ((angleI + progress) % (2 * pi) / (2 * pi) * 2047).round();
        int imageY = ((y + radius) / (2 * radius) * 1023).round();
        int color = MoonUtil.image!.getPixel(imageX, imageY);
        int r = color & 255;
        int g = color >> 8 & 255;
        g = (g * 1.15).toInt();
        int b = color >> 16 & 255;
        b = (b * 1.3).toInt();
        r = r * (1 + brightness) < 255 ? (r * (1 + brightness)).round() : 255;
        r = r < 0 ? 0 : r;
        g = g * (1 + brightness) < 255 ? (g * (1 + brightness)).round() : 255;
        g = g < 0 ? 0 : g;
        b = b * (1 + brightness) < 255 ? (b * (1 + brightness)).round() : 255;
        b = b < 0 ? 0 : b;
        paint.color = Color.fromARGB(255, r, g, b);
        canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(MoonPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return update;
  }
}
