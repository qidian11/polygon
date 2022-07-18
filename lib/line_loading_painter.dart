import 'package:flutter/material.dart';
import 'dart:math';

class LineLoadingPainter extends CustomPainter {
  double lineNum;
  double totalLength;
  double progress;
  double maxProgress;
  double get lineLength => totalLength / lineNum;
  // 起伏宽度是总长度的1/2
  double get waveLength => totalLength / 2;
  // 起伏高度是起伏宽度的1/4
  double get waveHeight => waveLength / 4;
  LineLoadingPainter(
      {this.totalLength = 500.0,
      this.lineNum = 40,
      this.progress = 0.0,
      this.maxProgress = 20.0});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF2C343A)
      ..strokeWidth = 4;
    canvas.translate(size.width / 2, size.height / 2);
    Offset p1 = Offset(-totalLength / 2, 0);
    Offset p2 = Offset(p1.dx + lineLength - 4, 0);
    double height = 0;
    double centerX;
    double waveStartX = progress / maxProgress * (waveLength + totalLength) +
        (-totalLength / 2 - waveLength);
    for (int i = 0; i < lineNum; i++) {
      p1 = Offset(-totalLength / 2 + lineLength * i, 0);
      p2 = Offset(p1.dx + lineLength - 4, 0);
      centerX = (p1.dx + p1.dx + lineLength) / 2;
      print(
          'i:$i,centerX:$centerX,waveStartX:$waveStartX,waveStartX + waveLength:${waveStartX + waveLength}');
      if (waveStartX < centerX && centerX < (waveStartX + waveLength)) {
        height =
            -sin((centerX - waveStartX) * 2 * pi / waveLength) * waveHeight;
        print('${((centerX - waveStartX) * pi / waveLength) / pi}');
        // } else if (waveStartX < p1.dx && p1.dx < (waveStartX + waveLength)) {
        //   height = -sin((p1.dx - waveStartX) * pi / waveLength) * waveLength / 2;
        //   print('${((p1.dx - waveStartX) * pi / waveLength) / pi}');
        // } else if (waveStartX < p2.dx && p2.dx < (waveStartX + waveLength)) {
        //   height = -sin((p2.dx - waveStartX) * pi / waveLength) * waveLength / 2;
        //   print(((p2.dx - waveStartX) * pi / waveLength) / pi);
      } else {
        height = 0;
      }
      p1 = Offset(p1.dx, height);
      p2 = Offset(p2.dx, height);
      canvas.drawLine(p1, p2, paint);

      // canvas.translate(p2.dx + 4, p2.dy);
      // canvas.rotate((progress / 20.0) * 2 * pi / lineNum);
    }
  }

  @override
  bool shouldRepaint(LineLoadingPainter oldDelegate) {
    return true;
  }
}
