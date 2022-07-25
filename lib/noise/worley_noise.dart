import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:polygon/util/index.dart';
import 'noise_util.dart';

class WorleyNoise {
  WorleyNoise();
  static Offset? closetGridPoint;
  static getWorleyNoise(double x, double y) {
    Offset point = Offset(x, y);
    double value = getNeighborDitance(point);
    value = value / sqrt(2);
    return value;
  }

  static getRoundWorleyNoise(double x, double y) {
    Offset point = Offset(x, y);
    double value1 = getNeighborDitance(point);
    // the frid point that closest to point
    Offset gridPoint1 = closetGridPoint!;
    double value2 = getNeighborDitanceExceptThePoint(gridPoint1);
    if (value1 > value2 / 2) {
      // print("value2:$value2,gridPoint1:$gridPoint1");
      return 1.0;
    }
    value1 = value1 / (value2 / 2);
    return value1;
  }

  static Offset getGridPoint(int x, int y) {
    int tempX = x;
    int tempY = y;
    while (tempX < 0) {
      tempX += 255;
    }
    while (tempY < 0) {
      tempY += 255;
    }
    int numX = NoiseUtil.permutation[
        (NoiseUtil.permutation[tempX % NoiseUtil.permutation.length] + tempY) %
            NoiseUtil.permutation.length];
    int numY = NoiseUtil.permutation[
        (NoiseUtil.permutation[tempY % NoiseUtil.permutation.length] + tempX) %
            NoiseUtil.permutation.length];

    return Offset(x + numX / 256, y + numY / 256);
  }

  static double distance(Offset point1, Offset point2) {
    return sqrt(pow(point1.dx - point2.dx, 2) + pow(point1.dy - point2.dy, 2));
  }

  static double getNeighborDitance(Offset point) {
    int xIndex = point.dx.floor();
    int yIndex = point.dy.floor();
    double dist = 1000000;
    for (int i = xIndex - 1; i < xIndex + 2; i++) {
      for (int j = yIndex - 1; j < yIndex + 2; j++) {
        Offset gridPoint = getGridPoint(i, j);
        if (point.dx == gridPoint.dx && point.dy == gridPoint.dy) {
          return 0.0;
        }
        double tempDist = distance(point, gridPoint);
        tempDist < dist ? closetGridPoint = gridPoint : null;
        dist = tempDist < dist ? tempDist : dist;
      }
    }
    return dist;
  }

  // get distance except the given point
  static double getNeighborDitanceExceptThePoint(Offset point) {
    int xIndex = point.dx.floor();
    int yIndex = point.dy.floor();
    double dist = 1000000;
    for (int i = xIndex - 1; i < xIndex + 2; i++) {
      for (int j = yIndex - 1; j < yIndex + 2; j++) {
        Offset gridPoint = getGridPoint(i, j);
        if (point.dx == gridPoint.dx && point.dy == gridPoint.dy) {
          continue;
        }
        double tempDist = distance(point, gridPoint);
        tempDist < dist
            ? closetGridPoint = Offset(gridPoint.dx, gridPoint.dy)
            : null;
        dist = tempDist < dist ? tempDist : dist;
      }
    }
    return dist;
  }
}
