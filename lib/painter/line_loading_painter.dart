import 'package:flutter/material.dart';
import 'my_painter.dart';
import 'dart:math';

class LineLoadingPainter extends MyPainter {
  double lineNum;
  double totalLength;
  double progress;
  double maxProgress;
  double lineSpace;
  double get lineLength => totalLength / lineNum;
  // 起伏宽度是总长度的1/2
  double get waveLength => totalLength / 2;
  // 起伏高度是起伏宽度的1/4
  double get waveHeight => waveLength / 4;
  LineLoadingPainter(
      {this.totalLength = 500.0,
      this.lineNum = 40,
      this.progress = 5.0,
      this.maxProgress = 200,
      this.lineSpace = 4.0});
  @override
  void paint(Canvas canvas, Size size) {
    if (totalLength > size.width) {
      totalLength = size.width;
    }
    Paint paint = Paint()
      ..color = const Color(0xFF2C343A)
      ..strokeWidth = 4;
    canvas.translate(size.width / 2, size.height / 2);
    Offset p1 = Offset(-totalLength / 2, 0);
    Offset p2 = Offset(p1.dx + lineLength - lineSpace, 0);
    double height = 0;
    // 斜率
    double gradient = 0;
    double angle = 0.0;
    double centerX;
    double waveStartX = progress / maxProgress * (waveLength + totalLength) +
        (-totalLength / 2 - waveLength);
    for (int i = 0; i < lineNum; i++) {
      // part line start and end points
      p1 = Offset(-totalLength / 2 + lineLength * i, 0);
      p2 = Offset(p1.dx + lineLength - lineSpace, 0);
      centerX = (p1.dx + p1.dx + lineLength) / 2;

      if (waveStartX < centerX && centerX < (waveStartX + waveLength)) {
        height =
            -sin((centerX - waveStartX) * 2 * pi / waveLength) * waveHeight;
        gradient = -cos((centerX - waveStartX) * 2 * pi / waveLength) *
            waveHeight *
            2 *
            pi /
            waveLength;
        angle = atan(gradient);
      } else {
        gradient = 0;
        angle = 0;
        height = 0;
      }
      p1 = Offset(p1.dx, height);
      p2 = Offset(p2.dx, height);

      // rotate with gradient
      {
        p1 = Offset(centerX - (lineLength / 2) * cos(angle),
            height - (lineLength / 2) * sin(angle));
        p2 = Offset(centerX + ((lineLength / 2) - lineSpace) * cos(angle),
            height + ((lineLength / 2) - lineSpace) * sin(angle));
      }
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(LineLoadingPainter oldDelegate) {
    return true;
  }
}
