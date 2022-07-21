import 'package:flutter/material.dart';
import 'package:polygon/page/index.dart';
import 'package:polygon/painter/index.dart';

class CommonUtil {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState navigatorState = navigatorKey.currentState!;
  static Map<String, CustomPainter> page2painter = {
    Circle2LinePage.sName: Circle2LinePainter(),
    GridPage.sName: GridPainter(),
    LineLoadingPage.sName: LineLoadingPainter(),
    PaperPage.sName: PaperPainter(),
    PolygonPage.sName: PolygonPainter(),
  };
  static List<String> pageList = [
    Circle2LinePage.sName,
    GridPage.sName,
    LineLoadingPage.sName,
    PaperPage.sName,
    PolygonPage.sName,
  ];
}
