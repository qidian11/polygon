import 'package:flutter/material.dart';
import 'dart:math';

class PaperPainter extends CustomPainter {
  double paperNum;
  double paperHeight;
  double offset;
  double maxProgress;

  double get perspectiveHeight => paperHeight - paperHeight / 5;
  // 起伏宽度是总长度的1/2
  double get waveLength => paperHeight / 2;
  // 起伏高度是起伏宽度的1/4
  double get waveHeight => waveLength / 4;
  PaperPainter({
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
      ..strokeWidth = 1;
    canvas.translate(size.width / 2, size.height / 2);
    double coverWidth = 4;
    // List<Path> paperPathList = getPaperPathList(progress, size);
    paint.color = const Color(0xFF99ACC2);

    canvas.drawRect(
        Rect.fromLTRB(
            -size.width / 2, -size.height / 5, size.width / 2, size.height / 5),
        paint);
    paint.color = const Color(0xFF2C343A);
    List<List<Offset>> paperPointsList = getPaperPointsList(offset, size);
    for (int i = 0; i < paperPointsList.length; i++) {
      Offset p1 = paperPointsList[i][0];
      Offset pP1 = paperPointsList[i][1];
      Offset p2 = paperPointsList[i][2];
      Offset pP2 = paperPointsList[i][3];
      if (p1.dx == pP1.dx) {
        paint.style = PaintingStyle.stroke;
        canvas.drawLine(p1, p2, paint);
        paint.style = PaintingStyle.fill;
      } else {
        // canvas.drawLine(p1, pP1, paint);
        // Offset newPP2 = Offset(pP2.dx, pP2.dy - coverWidth / 2);
        // Offset newPP1 = Offset(pP1.dx, pP1.dy + coverWidth / 2);
        // canvas.drawLine(newPP1, newPP2, paint);
        // canvas.drawLine(pP2, p2, paint);
        // Offset newP2 = Offset(p2.dx, p2.dy - coverWidth / 2);
        // Offset newP1 = Offset(p1.dx, p1.dy + coverWidth / 2);
        // canvas.drawLine(newP2, newP1, paint);

        Path path = Path();
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(pP1.dx, pP1.dy);
        path.lineTo(pP2.dx, pP2.dy);
        path.lineTo(p2.dx, p2.dy);
        path.lineTo(p1.dx, p1.dy);
        path.close();
        // paint.strokeWidth = coverWidth;
        // paint.style = PaintingStyle.stroke;
        canvas.drawPath(path, paint);
        // paint.strokeWidth = 1;
        // paint.style = PaintingStyle.fill;
        // canvas.drawPath(path, paint);
      }
    }
  }

  List<List<Offset>> getPaperPointsList(double offset, Size size) {
    double paperSpace = size.width / (paperNum - 1);
    offset = offset % paperSpace;
    List<List<Offset>> paperPointsList = [];
    Path path;
    double paperX;
    double perspectivePaperX;
    for (int i = 0; i < paperNum + 2; i++) {
      path = Path();
      paperX = paperSpace * (i - 1) - size.width / 2 + offset;
      Offset p1 = Offset(paperX, paperHeight / 2);
      Offset p2 = Offset(paperX, -paperHeight / 2);

      perspectivePaperX = perspectiveHeight / paperHeight * paperX;
      Offset pP1 = Offset(perspectivePaperX, perspectiveHeight / 2);
      Offset pP2 = Offset(perspectivePaperX, -perspectiveHeight / 2);
      paperPointsList.add([p1, pP1, p2, pP2]);
    }
    return paperPointsList;
  }

  List<Path> getPaperPathList(double offset, Size size) {
    double paperSpace = size.width / (paperNum - 1);
    offset = offset % paperSpace;
    List<Path> paperPathList = [];
    Path path;
    double paperX;
    double perspectivePaperX;
    for (int i = 0; i < paperNum + 2; i++) {
      path = Path();
      paperX = paperSpace * (i - 1) - size.width / 2 + offset;
      Offset p1 = Offset(paperX, paperHeight / 2);
      Offset p2 = Offset(paperX, -paperHeight / 2);

      perspectivePaperX = perspectiveHeight / paperHeight * paperX;
      Offset pP1 = Offset(perspectivePaperX, perspectiveHeight / 2);
      Offset pP2 = Offset(perspectivePaperX, -perspectiveHeight / 2);
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(pP1.dx, pP1.dy);
      path.lineTo(pP2.dx, pP2.dy);
      path.lineTo(p2.dx, p2.dy);
      path.lineTo(p1.dx, p1.dy);
      paperPathList.add(path);
    }
    return paperPathList;
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}
