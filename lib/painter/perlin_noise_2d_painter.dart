import 'package:flutter/cupertino.dart';
import 'package:polygon/noise/index.dart';
import 'dart:math';

class PerlinNoise2dPainter extends CustomPainter {
  double progress;
  double maxProgress;
  double scale;
  PerlinNoise2dPainter(
      {this.progress = 0, this.maxProgress = 20, this.scale = 0.02});
  double get rotation => progress / maxProgress * 2 * pi;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = const Color(0xFF2C343A)
      ..strokeWidth = 1.0;
    double x, y;
    for (int i = -500; i < 500; i++) {
      x = i.toDouble();
      for (int j = -500; j < 500; j++) {
        y = j.toDouble();
        // print('progress:$progress,this rotation:$rotation');
        double value = PerlinNoise.getD2PerlinNoise(i * scale, j * scale,
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
          // scan from top to bottom from left to right
          // if (x == -100 && y == -100) {
          //   getOutRangePixels(x - 1, y, [1], canvas, paint);
          //   getOutRangePixels(x, y - 1, [2], canvas, paint);
          // }
          // else if (x == -100 && y == 100) {
          //   getOutRangePixels(x, y + 1, [4], canvas, paint);
          // } else if (x == -100) {
          //   double value1 = PerlinNoise.getD2PerlinNoise(
          //       x * scale, (y - 1) * scale,
          //       rotation: rotation);
          //   value1 += 1;
          //   value1 /= 2;
          //   int color1 = (value1 * 255).round();
          //   if (color1 > 128) {
          //     getOutRangePixels(x - 1, y, [1], canvas, paint);
          //   }

        }
      }
    }
  }

  // getOutRangePixels(double x, double y, List<int> fromDirections, Canvas canvas,
  //     Paint paint) {
  //   // fromDirections 1->from right 2->bottom 3->left 4->top
  //   double value =
  //       PerlinNoise.getD2PerlinNoise(x * scale, y * scale, rotation: rotation);
  //   value += 1;
  //   value /= 2;
  //   int color = (value * 255).round();
  //   if (color > 128) {
  //     return;
  //   } else {
  //     paint.color = Color.fromARGB(255, color, color, color);
  //     // paint.color = Color(0xFF000000);
  //     canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1, paint);
  //   }

  //   if (!fromDirections.contains(1)) {
  //     List<int> newList = List.from(fromDirections);
  //     if (!fromDirections.contains(3)) {
  //       newList.add(3);
  //     }

  //     getOutRangePixels(x + 1, y, newList, canvas, paint);
  //   } else if (!fromDirections.contains(2)) {
  //     List<int> newList = List.from(fromDirections);
  //     if (!fromDirections.contains(4)) {
  //       newList.add(4);
  //     }
  //     getOutRangePixels(x, y + 1, newList, canvas, paint);
  //   }
  //   if (!fromDirections.contains(3)) {
  //     List<int> newList = List.from(fromDirections);
  //     if (!fromDirections.contains(1)) {
  //       newList.add(1);
  //     }
  //     getOutRangePixels(x - 1, y, newList, canvas, paint);
  //   }
  //   if (!fromDirections.contains(4)) {
  //     List<int> newList = List.from(fromDirections);
  //     if (!fromDirections.contains(2)) {
  //       newList.add(2);
  //     }
  //     getOutRangePixels(x, y - 1, newList, canvas, paint);
  //   }
  // }

  @override
  bool shouldRepaint(PerlinNoise2dPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
