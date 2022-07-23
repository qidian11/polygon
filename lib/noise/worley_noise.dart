import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:polygon/util/index.dart';
import 'noise_util.dart';

class WorleyNoise {
  WorleyNoise();
  static getWorleyNoise(double x, double y) {
    Offset point = Offset(x, y);
    double value = getNeighborDitance(point);
    value = value / sqrt(2);
    return value;
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
        if (point == gridPoint) {
          return 0.0;
        }
        double tempDist = distance(point, gridPoint);

        dist = tempDist < dist ? tempDist : dist;
      }
    }
    return dist;
  }
}
