import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:polygon/util/index.dart';
import 'noise_util.dart';

enum PerlinNoiseType { d1, d2, d3 }

class PerlinNoise {
  PerlinNoise();

  static Offset getConstantVector(int v, {double rotation = 0}) {
    //v is the value from the permutation table
    int h = v & 3;
    if (h == 0) {
      return const Offset(1.0, 1.0).rotate(rotation);
    } else if (h == 1) {
      return const Offset(-1.0, 1.0).rotate(rotation);
    } else if (h == 2) {
      return const Offset(-1.0, -1.0).rotate(rotation);
    } else {
      return const Offset(1.0, -1.0).rotate(rotation);
    }
  }

  static double lerp(num a, num b, num t) {
    // return a * (1 - f(t)) + b * f(t);
    return a + (b - a) * f(t);
  }

  static double f(num t) {
    return 6 * pow(t, 5) - 15 * pow(t, 4) + 10 * pow(t, 3).toDouble();
  }

  static double getD1PerlinNoise(double x, double y, {double rotation = 0}) {
    double xf = x - x.floor();
    double yf = y - y.floor();

    int xIndex = x.floor();
    int yIndex = y.floor();

    int leftValue = NoiseUtil.permutation[
        (NoiseUtil.permutation[xIndex % NoiseUtil.permutation.length] +
                yIndex) %
            NoiseUtil.permutation.length];
    int rightValue = NoiseUtil.permutation[
        (NoiseUtil.permutation[(xIndex + 1) % NoiseUtil.permutation.length] +
                yIndex) %
            NoiseUtil.permutation.length];
    Offset leftVector = getConstantVector(leftValue, rotation: rotation);
    Offset rightVector = getConstantVector(rightValue, rotation: rotation);
    Offset right = Offset(xf - 1, 0);
    Offset left = Offset(xf, 0);
    double dotRight = right.dot(rightVector);
    double dotLeft = left.dot(leftVector);
    // print(
    //     'i:$i,index:$index,f1:$f1,f2:$f2,partLength:$partLength,dotProduct1:$dotProduct1,dotProduct2:$dotProduct2');
    double value = lerp(dotLeft, dotRight, xf);
    return value;
  }

  static double getD2PerlinNoise(double x, double y, {double rotation = 0}) {
    double xf = x - x.floor();
    double yf = y - y.floor();

    int xFloor = x.floor();
    int yFloor = y.floor();
    int xCeil = xFloor + 1;
    int yCeil = yFloor + 1;
    if (xFloor < 0) {
      xFloor = NoiseUtil.permutation[23] + xFloor.abs();
      if (xCeil != 0) {
        xCeil = NoiseUtil.permutation[23] + xCeil.abs();
      }
    }
    if (yFloor < 0) {
      yFloor = NoiseUtil.permutation[76] + yFloor.abs();
      if (yCeil != 0) {
        yCeil = NoiseUtil.permutation[76] + yCeil.abs();
      }
    }

    int topLeftValue = NoiseUtil.permutation[
        (NoiseUtil.permutation[xFloor % NoiseUtil.permutation.length] +
                yFloor) %
            NoiseUtil.permutation.length];
    int bottomLeftValue = NoiseUtil.permutation[
        (NoiseUtil.permutation[xFloor % NoiseUtil.permutation.length] + yCeil) %
            NoiseUtil.permutation.length];
    int topRightValue = NoiseUtil.permutation[
        (NoiseUtil.permutation[xCeil % NoiseUtil.permutation.length] + yFloor) %
            NoiseUtil.permutation.length];
    int bottomRightValue = NoiseUtil.permutation[
        (NoiseUtil.permutation[xCeil % NoiseUtil.permutation.length] + yCeil) %
            NoiseUtil.permutation.length];
    Offset topLeftVector = getConstantVector(topLeftValue, rotation: rotation);
    Offset bottomLeftVector =
        getConstantVector(bottomLeftValue, rotation: rotation);
    Offset topRightVector =
        getConstantVector(topRightValue, rotation: rotation);
    Offset bottomRightVector =
        getConstantVector(bottomRightValue, rotation: rotation);
    Offset topRight = Offset(xf - 1, yf);
    Offset topLeft = Offset(xf, yf);
    Offset bottomRight = Offset(xf - 1, yf - 1);
    Offset bottomLeft = Offset(xf, yf - 1);
    double dotTopRight = topRight.dot(topRightVector);
    double dotTopLeft = topLeft.dot(topLeftVector);
    double dotBottomRight = bottomRight.dot(bottomRightVector);
    double dotBottomLeft = bottomLeft.dot(bottomLeftVector);
    // print(
    //     'i:$i,index:$index,f1:$f1,f2:$f2,partLength:$partLength,dotProduct1:$dotProduct1,dotProduct2:$dotProduct2');
    double topLerp = lerp(dotTopLeft, dotTopRight, xf);
    double bottomLerp = lerp(dotBottomLeft, dotBottomRight, xf);
    double value = lerp(topLerp, bottomLerp, yf);
    return value;
  }
}
