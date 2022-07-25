import 'package:flutter/material.dart';
import 'package:polygon/noise/index.dart';
import 'package:polygon/util/sphere_util.dart';
import 'my_painter.dart';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:polygon/noise/index.dart';
import 'dart:math';

class SphereNoisePainter extends CustomPainter {
  double progress;
  double maxProgress;
  double radius;
  List<List<double>>? get pixels => SphereUtil.pixels;
  SphereNoisePainter(
      {this.progress = 0, this.maxProgress = 2 * pi, this.radius = 20}) {
    if (SphereUtil.pixels == null) {
      SphereUtil.pixels = [];
      for (int i = 0; i < 2 * radius; i++) {
        List<double> pixelList = [];
        for (int j = 0; j < 2 * radius; j++) {
          double cosAngleI = (radius - i) / radius;
          double cosAngleJ = (radius - j) / radius;
          double angleI = acos(cosAngleI);
          double angleJ = acos(cosAngleJ);
          // print(angleI);
          double projectionI = radius * (angleI + progress);
          double projectionJ = radius * (angleJ);
          // double value = PerlinNoise.getD2PerlinNoise(
          //     projectionI * 0.1, projectionJ * 0.1,
          //     rotation: rotation);
          // value += 1;
          // value /= 2;
          // int color = (value * 255).round();

          // color = color;
          // paint.color = Color.fromARGB(255, color, color, color);
          // // paint.color = Color(0xFF000000);
          // canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);

          // worley noise
          // double value =
          // WorleyNoise.getWorleyNoise(projectionI * 0.02, projectionJ * 0.02);
          double value1 = WorleyNoise.getRoundWorleyNoise(
              projectionI * 0.01, projectionJ * 0.01);
          // value1:0->0.8:0.8->0.7;0.8->0.95:0.7->1;0.95->1:1->0.4
          if (value1 < 0.8) {
            value1 = -0.1 * value1 + 0.8;
          } else if (value1 < 0.95) {
            value1 = 2 * (value1 - 0.8) + 0.7;
          } else {
            value1 = -12 * (value1 - 0.95) + 1;
          }
          double value2 = WorleyNoise.getRoundWorleyNoise(
              projectionI * 0.05, projectionJ * 0.05);
          // value1:0->0.8:0.8->0.7;0.8->0.95:0.7->1;0.95->1:1->0.4
          if (value2 < 0.8) {
            value2 = -0.1 * value2 + 0.8;
          } else if (value2 < 0.95) {
            value2 = 2 * (value2 - 0.8) + 0.7;
          } else {
            value2 = -12 * (value2 - 0.95) + 1;
          }
          double value3 = PerlinNoise.getD2PerlinNoise(
              projectionI * 0.1, projectionJ * 0.1);
          double value4 = PerlinNoise.getD2PerlinNoise(
              projectionI * 0.4, projectionJ * 0.4);
          value3 += 1;
          value3 /= 2;
          value4 += 1;
          value4 /= 2;

          double value =
              value1 * 0.50 + value2 * 0.15 + value3 * 0.25 + value4 * 0.1;
          // value1:0->0.8:0.5->0.7;0.8->0.9:0.7->1;0.9->1:1->0.4
          // if (value < 0.8) {
          //   value = 0.25 * value + 0.5;
          // } else if (value < 0.9) {
          //   value = 3 * (value - 0.8) + 0.7;
          // } else {
          //   value = -6 * (value - 0.95) + 1;
          // }
          // int colorValue = (value * -255 + 255).round();
          // if (colorValue > 240) {
          //   colorValue = 250;
          // } else if (colorValue > 200) {
          //   colorValue = 40;
          // } else if (colorValue > 170) {
          //   colorValue = 240;
          // } else {
          //   colorValue = 250;
          // }
          pixelList.add(value);

          // Color color = Color.fromARGB(255, colorValue, colorValue, colorValue);
          // paint.color = color;
          // canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
        }

        SphereUtil.pixels!.add(pixelList);
      }
    }
  }

  double get rotation => progress / maxProgress * 2 * pi;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = const Color(0xFF2C343A)
      ..strokeWidth = 1.0;
    double x, y;
    for (int i = 0; i < pixels!.length; i++) {
      x = i - radius;
      List list = pixels![i];
      for (int j = 0; j < list.length; j++) {
        y = j - radius;
        if ((x * x + y * y) > radius * radius) {
          continue;
        }
        double sum = 0;
        int count = 0;
        for (int k = i - 2; k < i + 3; k++) {
          for (int l = j - 2; l < j + 3; l++) {
            if (k == i && l == j) {
              continue;
            }
            if (k >= 0 && k < pixels!.length && l >= 0 && l < list.length) {
              sum += pixels![k][l];
              count++;
            }
          }
        }
        double average = sum / count;
        double value = (pixels![i][j] - average).abs();
        int colorValue = (value * -255 + 255).round();
        Color color = Color.fromARGB(255, colorValue, colorValue, colorValue);
        paint.color = color;
        canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SphereNoisePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
