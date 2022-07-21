import 'package:flutter/material.dart';

import 'package:polygon/util/common_util.dart';

enum ToastPosition { top, end, center }

class ToastUtil {
  static OverlayEntry? overlayEntry;

  static void showToast(
      {required Widget child,
      ToastPosition position = ToastPosition.center,
      Color color = Colors.white,
      Color barrierColor = const Color(0x99CCCCCC)}) {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;
    if (position == ToastPosition.top) {
      mainAxisAlignment = MainAxisAlignment.start;
    } else if (position == ToastPosition.end) {
      mainAxisAlignment = MainAxisAlignment.end;
    }
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          overlayEntry?.remove();
        },
        child: Material(
            color: barrierColor,
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              children: [Card(color: color, child: child)],
            )),
      );
    });
    CommonUtil.navigatorState.overlay!.insert(overlayEntry!);
  }

  static void myShowModalBottomSheet(
      {required Widget child,
      Color color = Colors.white,
      Color barrierColor = const Color(0x99CCCCCC)}) {
    BuildContext context = CommonUtil.navigatorState.overlay!.context;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return child;
      },
      backgroundColor: color,
      barrierColor: barrierColor,
    );
  }
}
