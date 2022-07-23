import 'package:flutter/material.dart';
import 'package:polygon/page/index.dart';
import 'package:polygon/painter/index.dart';

class CommonUtil {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState navigatorState = navigatorKey.currentState!;
  static Map<String, CustomPainter> page2painter = {
    Circle2LinePage.sName: Circle2LinePainter(),
    LineLoadingPage.sName: LineLoadingPainter(),
    PaperPage.sName: PaperPainter(),
    PerlinNoise2dPage.sName: PerlinNoise2dPainter(),
    PerlinNoise1dPage.sName: PerlinNoise1dPainter(),
    PolygonPage.sName: PolygonPainter(),
  };
  static List<String> pageList = [
    Circle2LinePage.sName,
    LineLoadingPage.sName,
    PaperPage.sName,
    PerlinNoise1dPage.sName,
    PerlinNoise2dPage.sName,
    PolygonPage.sName,
  ];
}
