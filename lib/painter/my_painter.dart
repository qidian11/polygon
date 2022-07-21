import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  double progress;
  double maxProgress;

  MyPainter({this.progress = 0.0, this.maxProgress = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.progress != progress;
  }
}
