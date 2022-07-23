import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:polygon/util/index.dart';

enum PerlinNoiseType { d1, d2, d3 }

class PerlinNoise {
  PerlinNoise();
  static List permutation = [
    151,
    160,
    137,
    91,
    90,
    15,
    131,
    13,
    201,
    95,
    96,
    53,
    194,
    233,
    7,
    225,
    140,
    36,
    103,
    30,
    69,
    142,
    8,
    99,
    37,
    240,
    21,
    10,
    23,
    190,
    6,
    148,
    247,
    120,
    234,
    75,
    0,
    26,
    197,
    62,
    94,
    252,
    219,
    203,
    117,
    35,
    11,
    32,
    57,
    177,
    33,
    88,
    237,
    149,
    56,
    87,
    174,
    20,
    125,
    136,
    171,
    168,
    68,
    175,
    74,
    165,
    71,
    134,
    139,
    48,
    27,
    166,
    77,
    146,
    158,
    231,
    83,
    111,
    229,
    122,
    60,
    211,
    133,
    230,
    220,
    105,
    92,
    41,
    55,
    46,
    245,
    40,
    244,
    102,
    143,
    54,
    65,
    25,
    63,
    161,
    1,
    216,
    80,
    73,
    209,
    76,
    132,
    187,
    208,
    89,
    18,
    169,
    200,
    196,
    135,
    130,
    116,
    188,
    159,
    86,
    164,
    100,
    109,
    198,
    173,
    186,
    3,
    64,
    52,
    217,
    226,
    250,
    124,
    123,
    5,
    202,
    38,
    147,
    118,
    126,
    255,
    82,
    85,
    212,
    207,
    206,
    59,
    227,
    47,
    16,
    58,
    17,
    182,
    189,
    28,
    42,
    223,
    183,
    170,
    213,
    119,
    248,
    152,
    2,
    44,
    154,
    163,
    70,
    221,
    153,
    101,
    155,
    167,
    43,
    172,
    9,
    129,
    22,
    39,
    253,
    19,
    98,
    108,
    110,
    79,
    113,
    224,
    232,
    178,
    185,
    112,
    104,
    218,
    246,
    97,
    228,
    251,
    34,
    242,
    193,
    238,
    210,
    144,
    12,
    191,
    179,
    162,
    241,
    81,
    51,
    145,
    235,
    249,
    14,
    239,
    107,
    49,
    192,
    214,
    31,
    181,
    199,
    106,
    157,
    184,
    84,
    204,
    176,
    115,
    121,
    50,
    45,
    127,
    4,
    150,
    254,
    138,
    236,
    205,
    93,
    222,
    114,
    67,
    29,
    24,
    72,
    243,
    141,
    128,
    195,
    78,
    66,
    215,
    61,
    156,
    180
  ];

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

  static List<Offset> getRandomList(double num, double range) {
    List<Offset> list = [];
    for (int i = 0; i < num; i++) {
      list.add(Offset(Random().nextDouble() * range - range / 2,
          Random().nextDouble() * range - range / 2));
    }
    return list;
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

    int leftValue = permutation[permutation[xIndex] + yIndex];
    int rightValue = permutation[permutation[xIndex + 1] + yIndex];
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

    int xIndex = x.floor();
    int yIndex = y.floor();

    int topLeftValue = permutation[permutation[xIndex] + yIndex];
    int bottomLeftValue = permutation[permutation[xIndex] + yIndex + 1];
    int topRightValue = permutation[permutation[xIndex + 1] + yIndex];
    int bottomRightValue = permutation[permutation[xIndex + 1] + yIndex + 1];
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
