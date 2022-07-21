import 'package:flutter/material.dart';
import 'package:polygon/page/index.dart';
import 'package:polygon/painter/index.dart';
import 'package:polygon/util/index.dart';

class FrameWidget extends StatefulWidget {
  int index;
  double width;
  FrameWidget({required this.index, required this.width, Key? key})
      : super(key: key);

  @override
  State<FrameWidget> createState() => _FrameWidgetState();
}

class _FrameWidgetState extends State<FrameWidget>
    with SingleTickerProviderStateMixin {
  late int index;
  late double width;
  late double height;

  late Tween<double> tween;
  late AnimationController animationController;
  late Animation<double> animation;
  double progress = 0.0;
  double frameBorderWidth = 8.0;
  double framePadding = 5.0;
  Offset frameShadowOffset = const Offset(10, 4);
  bool reverse = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
    width = widget.width;
    height = width;
    if (CommonUtil.pageList[index] == PolygonPage.sName ||
        CommonUtil.pageList[index] == Circle2LinePage.sName) {
      reverse = true;
    }
    tween = Tween(begin: 0.0, end: 1);
    animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = tween.animate(animationController);
    animation.addListener(() {
      progress = animation.value;
      setState(() {});
    });
    animationController.repeat(reverse: reverse);
  }

  @override
  Widget build(BuildContext context) {
    dynamic painter = PolygonPainter();
    switch (CommonUtil.pageList[index]) {
      case Circle2LinePage.sName:
        painter = Circle2LinePainter();
        break;
      case GridPage.sName:
        painter = GridPainter();
        break;
      case LineLoadingPage.sName:
        painter = LineLoadingPainter();
        break;
      case PaperPage.sName:
        painter = PaperPainter(
            maxProgress:
                1 * width / 2 - 2 * framePadding - 2 * frameBorderWidth);
        break;
      case PolygonPage.sName:
        painter = PolygonPainter();
        break;
    }
    painter!.progress = progress * painter.maxProgress;
    return GestureDetector(
      onTap: () {
        NavigationUtil.instance.pushNamed(CommonUtil.pageList[index]);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFD3DBDF),
        ),
        child: Center(
          child: Container(
            width: 1 * width / 2,
            height: 3 * height / 4,
            padding: EdgeInsets.all(framePadding),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xFF2C343A), width: frameBorderWidth),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF2C343A).withOpacity(0.4),
                      offset: frameShadowOffset,
                      blurRadius: 5)
                ]),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              // child: CustomPaint(painter: painter),
              child: CustomPaint(painter: painter),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}
