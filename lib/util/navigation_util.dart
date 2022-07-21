import 'package:flutter/material.dart';
import 'package:polygon/util/common_util.dart';
import 'package:polygon/page/index.dart';

class NavigationUtil extends RouteObserver {
  static NavigatorState navigatorState = CommonUtil.navigatorKey.currentState!;
  static BuildContext context = CommonUtil.navigatorKey.currentContext!;
  static Map<String, WidgetBuilder> configRoutes = {
    Circle2LinePage.sName: (_) => const Circle2LinePage(),
    GridPage.sName: (_) => const GridPage(),
    LineLoadingPage.sName: (_) => const LineLoadingPage(),
    PaperPage.sName: (_) => const PaperPage(),
    PolygonPage.sName: (_) => const PolygonPage(),
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
