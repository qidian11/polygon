import 'package:flutter/material.dart';
import 'package:polygon/util/common_util.dart';
import 'package:polygon/page/index.dart';

class NavigationUtil extends RouteObserver {
  static NavigatorState navigatorState = CommonUtil.navigatorKey.currentState!;
  static BuildContext context = CommonUtil.navigatorKey.currentContext!;
  static Map<String, WidgetBuilder> configRoutes = {
    Circle2LinePage.sName: (_) => const Circle2LinePage(),
    LineLoadingPage.sName: (_) => const LineLoadingPage(),
    PaperPage.sName: (_) => const PaperPage(),
    PerlinNoise1dPage.sName: (_) => const PerlinNoise1dPage(),
    PerlinNoise2dPage.sName: (_) => const PerlinNoise2dPage(),
    PolygonPage.sName: (_) => const PolygonPage(),
    WorleyNoisePage.sName: (_) => const WorleyNoisePage(),
  };

  static NavigationUtil instance = NavigationUtil._internal();

  factory NavigationUtil() {
    return NavigationUtil._internal();
  }

  NavigationUtil._internal();

  void pushNamed(String routeName, {Object? arguments}) {
    navigatorState.pushNamed(routeName, arguments: arguments);
  }

  void pop() {
    navigatorState.pop();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
  }
}
