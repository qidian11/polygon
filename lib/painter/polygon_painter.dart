import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class PolygonPainter extends CustomPainter {
  double radius;
  double sides;
  bool showDiagonal;
  bool showDots;
  double maxSides = 20.0;
  double progress;
  int dotsNum = 10;
  double dotRadius = 3.0;
  List<Offset> points = [];
  PolygonPainter(
      {this.sides = 7.0,
      this.radius = 100,
      this.progress = 0,
      this.showDiagonal = true,
      this.showDots = false});
  @override
  void paint(Canvas canvas, Size size) {
    // print('paint');
    if (radius > size.width / 2) {
      radius = size.width / 2;
    }
    Paint paint = Paint()
      ..color = const Color(0xFF47484B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    List<Offset> points = getPolygonPoints(sides);
    canvas.translate(size.width / 2, size.height / 2);
    // scale canvas
    double scale;
    // sin
    // 0->8:0.4->0.8 8->12:0.8->0.4 12->20:0.4->1
    if (sides.ceil() <= 8) {
      double angle = sides * pi / 8 - pi / 2;
      scale = sin(angle) / 5 + 0.6;
    } else if (sides.ceil() <= 12) {
      double angle = pi / 2 - (sides - 8) * pi / 4;
      scale = sin(angle) / 5 + 0.6;
    } else {
      double angle = (sides - 12) * pi / 8 - pi / 2;
      scale = sin(angle) / 3.333 + 0.7;
    }
    // line
    // 0->8:0.4->0.8 8->12:0.8->0.4 12->20:0.4->1
    // if (sides.ceil() <= 8) {
    //   scale = 0.4 + 0.05 * sides;
    // } else if (sides.ceil() <= 12) {
    //   scale = 0.8 - 0.1 * (sides - 8);
    // } else {
    //   scale = 0.4 + 0.6 / 8 * (sides - 12);
    // }
    print('scale:$scale,sides:$sides');
    // 偶变奇，斜率0.1，奇数变偶数，斜率-0.04，初始scale 0.4
    // double k1 = 0.5;
    // double k2 = -0.44;
    // double startScale = 0.4;
    // if (sides.floor() % 2 == 0) {
    //   double startY = sides.floor() / 2 * (k1 + k2) + startScale;
    //   int startX = sides.floor();
    //   scale = startY + k1 * (sides - startX);
    // } else {
    //   double startY = (sides - 1).floor() / 2 * (k1 + k2) + startScale + k1;
    //   int startX = sides.floor();
    //   scale = startY + k2 * (sides - startX);
    // }
    canvas.scale(scale);
    paint.color = const Color(0xFFA5CED8);
    canvas.drawPoints(PointMode.points, points, paint);
    // draw sides
    paint.color = const Color(0xFF2C343A);
    for (int i = 0; i < points.length; i++) {
      canvas.drawLine(
          points[i % points.length], points[(i + 1) % points.length], paint);
    }
    paint.color = const Color(0xFF47484B);
    // paint.color = const Color(0xFF99ACC2);

    // draw diagonal
    if (showDiagonal) {
      for (int i = 0; i < points.length; i++) {
        for (int j = 0; j < points.length; j++) {
          if (i < j && i % points.length != (j - 1) % points.length) {
            canvas.drawLine(
                points[i % points.length], points[(j) % points.length], paint);
          }
        }
      }
    }

    // draw dots
    if (showDots) {
      PathStorage pathStorage = PathStorage();
      if (pathStorage.points.isEmpty) {
        pathStorage.points = points;
        int maxLineNum = sides * (sides - 1) ~/ 2;
        pathStorage.pathList = pathStorage.getPathList(maxLineNum, dotsNum);
      }
      List<Path> pathList = pathStorage.pathList;
      for (int i = 0; i < pathList.length; i++) {
        PathMetric metric = pathList[i].computeMetrics().first;
        Offset offset =
            metric.getTangentForOffset(metric.length * progress)!.position;
        paint.color = Colors.primaries[i];
        canvas.drawCircle(offset, dotRadius, paint);
      }
    }
  }

  List<Offset> getPolygonPoints1(double sides) {
    print(sides.ceil());
    for (int i = 0; i < sides.ceil(); i++) {
      double x, y;
      if (sides.ceil() % 2 == 0) {
        x = radius *
            sin(lerpDouble(0, (pi / sides), sides - sides.floor())! +
                i * 2 * pi / sides);
        y = -radius *
            cos(lerpDouble(0, (pi / sides), sides - sides.floor())! +
                i * 2 * pi / sides);
      } else {
        x = radius *
            sin(lerpDouble((pi / sides), 0, sides - sides.floor())! +
                i * 2 * pi / sides);
        y = -radius *
            cos(lerpDouble((pi / sides), 0, sides - sides.floor())! +
                i * 2 * pi / sides);
      }
      points.add(Offset(x, y));
    }
    return points;
  }

  List<Offset> getPolygonPoints(double sides) {
    for (int i = 0; i < sides.ceil(); i++) {
      double x, y;
      if (sides.ceil() % 2 == 0) {
        if (sides.ceil() == sides) {
          x = radius * sin((pi / sides) + i * 2 * pi / sides);
          y = -radius * cos((pi / sides) + i * 2 * pi / sides);
        } else {
          x = radius *
              sin(lerpDouble(0, (pi / sides), sides - sides.floor())! +
                  i * 2 * pi / sides);
          y = -radius *
              cos(lerpDouble(0, (pi / sides), sides - sides.floor())! +
                  i * 2 * pi / sides);
        }
      } else {
        if (sides.ceil() == sides) {
          x = radius * sin(i * 2 * pi / sides);
          y = -radius * cos(i * 2 * pi / sides);
        } else {
          if (i == 0) {
            double startY = -radius * cos(pi / sides);
            double endY = -radius;
            x = 0;
            y = lerpDouble(startY, endY, sides - sides.floor())!;
          } else {
            x = radius *
                sin(lerpDouble((pi / sides), 0, sides - sides.floor())! +
                    (i - lerpDouble(1, 0, sides - sides.floor())!) *
                        2 *
                        pi /
                        sides);
            y = -radius *
                cos(lerpDouble((pi / sides), 0, sides - sides.floor())! +
                    (i - lerpDouble(1, 0, sides - sides.floor())!) *
                        2 *
                        pi /
                        sides);
          }
        }
      }
      points.add(Offset(x, y));
    }
    return points;
  }

  List<Offset> getPolygonPoints2(double sides) {
    print(sides.ceil());
    for (int i = 0; i < sides.ceil(); i++) {
      double x, y;

      x = radius * sin(i * 2 * pi / sides);
      y = -radius * cos(i * 2 * pi / sides);

      points.add(Offset(x, y));
    }
    return points;
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) {
    return oldDelegate.sides != sides ||
        oldDelegate.showDots != showDots ||
        oldDelegate.showDiagonal != showDiagonal ||
        oldDelegate.progress != progress;
  }
}

class PathStorage {
  List<Offset> points = [];
  List<Path> pathList = [];
  static PathStorage instance = PathStorage._internal();
  factory PathStorage() {
    return instance;
  }
  PathStorage._internal();

  List<Path> getPathList(int maxLineNum, int dotsNum) {
    // 单条path中的line数量
    List<Path> pathList = [];
    List<Offset> pointList = [];
    int lineNum;

    print("maxLineNum:$maxLineNum");
    for (int i = 0; i < dotsNum; i++) {
      lineNum = 1 + Random().nextInt(maxLineNum + 1);
      Path path = Path();
      for (int j = 0; j < lineNum; j++) {
        Offset point = getRandomPoint();
        if (j == 0) {
          path.moveTo(point.dx, point.dy);
        } else if (j == 1) {
          while (point == pointList[0]) {
            point = getRandomPoint();
          }
          path.lineTo(point.dx, point.dy);
        } else {
          while (point == pointList[j - 2] || point == pointList[j - 1]) {
            point = getRandomPoint();
          }
          path.lineTo(point.dx, point.dy);
        }
        pointList.add(point);
      }
      pathList.add(path);
    }
    return pathList;
  }

  Offset getRandomPoint() {
    int index = Random().nextInt(points.length);
    Offset point = points[index];
    return point;
  }
}
