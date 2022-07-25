import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:polygon/util/moon_util.dart';
import 'package:polygon/util/extension_util.dart';
import 'package:polygon/noise/vector3.dart';

class MoontPainter extends CustomPainter {
  double progress;
  double maxProgress;
  double radius;
  bool update;
  Vector3 ray = Vector3(1, 1, 0);
  MoontPainter(
      {this.progress = 0,
      this.maxProgress = 2 * pi,
      this.radius = 150,
      this.update = true});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint();
    double x, y, z;
    double xSquare, ySquare;
    // for (double aX = 0; aX <= pi; aX += 0.01) {
    //   for (double aY = 0; aY <= pi; aY += 0.01) {
    //     if (aX == 0 && aY == 0) {
    //       x = -radius;
    //       y = -radius;
    //     } else if (aX == 0 && aY == pi) {
    //       x = -radius;
    //       y = radius;
    //     } else if (aX == pi && aY == 0) {
    //       x = radius;
    //       y = -radius;
    //     } else if (aX == pi && aY == pi) {
    //       x = radius;
    //       y = radius;
    //     } else {
    //       xSquare = radius.square *
    //           cos(aX).square *
    //           sin(aY).square /
    //           (1 - cos(aX).square * cos(aY).square);
    //       ySquare = radius.square *
    //           cos(aY).square *
    //           sin(aX).square /
    //           (1 - cos(aX).square * cos(aY).square);
    //       if (xSquare < 0) {
    //         print(xSquare);
    //       }
    //       if (aX < pi / 2 || aX > 3 * pi / 2) {
    //         x = -sqrt(xSquare);
    //       } else {
    //         x = sqrt(xSquare);
    //       }
    //       if (aY < pi / 2 || aY > 3 * pi / 2) {
    //         y = -sqrt(ySquare);
    //       } else {
    //         y = sqrt(ySquare);
    //       }
    //     }

    //     z = sqrt(radius * radius - (x * x + y * y));
    //     Vector3 v = Vector3(x, y, z);
    //     double dotValue = v.dot(ray);
    //     // double rayAnle = acos(dotValue / (v.length*ray.length));
    //     // rayAnle = pi-rayAnle;
    //     double brightness = -dotValue / (v.length * ray.length) - 0.5;
    //     int imageX = ((aX + progress) % (2 * pi) / (2 * pi) * 2047).round();
    //     int imageY = (aY / pi * 1023).round();
    //     int color = MoonUtil.image!.getPixel(imageX, imageY);
    //     int r = color & 255;
    //     int g = color >> 8 & 255;
    //     g = (g * 1.15).toInt();
    //     int b = color >> 16 & 255;
    //     b = (b * 1.3).toInt();
    //     r = r * (1 + brightness) < 255 ? (r * (1 + brightness)).round() : 255;
    //     r = r < 0 ? 0 : r;
    //     g = g * (1 + brightness) < 255 ? (g * (1 + brightness)).round() : 255;
    //     g = g < 0 ? 5 : g;
    //     b = b * (1 + brightness) < 255 ? (b * (1 + brightness)).round() : 255;
    //     b = b < 0 ? 10 : b;
    //     paint.color = Color.fromARGB(255, r, g, b);
    //     canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
    //   }
    // }
    for (int i = 0; i < 2 * radius; i++) {
      x = i - radius;
      double pRadiusX;
      double pRadiusY;
      // if (x == radius || x == -radius) {
      //   pRadiusY = radius;
      // } else {
      //   pRadiusY = sqrt(radius * radius - x * x);
      // }
      for (int j = 0; j < 2 * radius; j++) {
        y = j - radius;
        if (x * x + y * y > radius * radius) {
          continue;
        }
        z = sqrt(radius * radius - (x * x + y * y));
        Vector3 v = Vector3(x, y, z);
        double dotValue = v.dot(ray);
        // double rayAnle = acos(dotValue / (v.length*ray.length));
        // rayAnle = pi-rayAnle;
        double brightness = -dotValue / (v.length * ray.length) - 0.5;
        // if (brightness > 0.4) {
        //   print(brightness);
        // }

        if (y == radius || y == -radius) {
          pRadiusX = radius;
        } else {
          pRadiusX = sqrt(radius * radius - y * y);
        }

        // double cosAngleI = (radius - i) / radius;
        // double cosAngleJ = (radius - j) / radius;
        // print("x:$x,pRadiusX:$pRadiusX,pRadiusY:$pRadiusY");
        double cosAngleI = x / pRadiusX;
        // double cosAngleJ = y / pRadiusY;
        double angleI = acos(cosAngleI);
        // double angleJ = acos(cosAngleJ);
        // print(angleI);
        // double projectionI = pRadiusX * ((angleI + pi + progress) % (2 * pi));
        // double projectionJ = pRadiusY * ((angleJ + pi) % (2 * pi));
        // int imageX = (projectionI / (2 * pi * pRadiusX) * 2048).round();
        // int imageY = (projectionJ / (2 * pi * pRadiusY) * 1024).round();

        int imageX = ((angleI + progress) % (2 * pi) / (2 * pi) * 2047).round();
        // int imageY = (angleJ / (2 * pi) * 1024).round();
        int imageY = ((y + radius) / (2 * radius) * 1023).round();
        // if (imageX == 12 && imageY == 80) {
        //   print(
        //       "x:$x,y:$y,pRadiusX:$pRadiusX,pRadiusY:$pRadiusY,angleI:$angleI,angleJ:$angleJ");
        // }
        // print(MoonUtil.image!.height);
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
  bool shouldRepaint(MoontPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return update;
  }
}
