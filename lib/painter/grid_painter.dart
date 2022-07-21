import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

import 'package:polygon/painter/index.dart';

class GridPainter extends MyPainter {
  double paperNum;
  double paperHeight;
  double offset;
  double maxProgress;

  double get perspectiveHeight => paperHeight - paperHeight / 5;
  // 起伏宽度是总长度的1/2
  double get waveLength => paperHeight / 2;
  // 起伏高度是起伏宽度的1/4
  double get waveHeight => waveLength / 4;
  GridPainter({
    this.paperHeight = 300,
    this.paperNum = 9,
    this.offset = 0.0,
    this.maxProgress = 20.0,
  }) {
    if (paperNum % 2 == 0) {
      paperNum += 1;
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF2C343A)
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.1;
    canvas.translate(size.width / 2, size.height / 2);
    double x, y;
    List randomNums = [];
    for (int i = 0; i < 21; i++) {
      randomNums.add(Random().nextInt(100) - 50);
    }
    int index;
    double distance;
    for (int i = 0; i < size.width; i++) {
      x = (i - size.width / 2) ~/ 1 * 1.0;
      index = (x + size.width / 2) ~/ (size.width / 20);
      distance = (x + size.width / 2) % (size.width / 20);
      y = randomNums[index] * (distance / (size.width / 20)) +
          randomNums[index + 1] * (1 - distance / (size.width / 20));
      print(Offset(x, y));

      canvas.drawCircle(Offset(x, y), 1, paint);
    }
    // for (int i = 0; i < size.width; i += 1) {
    //   x = i - size.width / 2;
    //   Offset p1 = Offset(x, -size.height / 2);
    //   Offset p2 = Offset(x, size.height / 2);
    //   canvas.drawLine(p1, p2, paint);
    // }
    // for (int j = 0; j < size.height; j += 1) {
    //   y = j - size.height / 2;
    //   Offset p1 = Offset(-size.width / 2, y);
    //   Offset p2 = Offset(size.width / 2, y);

    //   canvas.drawLine(p1, p2, paint);
    // }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}
