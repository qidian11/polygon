import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:polygon/painter/index.dart';
import 'package:polygon/util/index.dart';

class MoonPage extends StatefulWidget {
  const MoonPage({Key? key}) : super(key: key);
  static const String sName = "Moon";
  @override
  State<MoonPage> createState() => _MoonPageState();
}

class _MoonPageState extends State<MoonPage>
    with SingleTickerProviderStateMixin {
  double progress = 0;
  double maxSides = 20.0;
  String sliderText = '0.0';
  double canvasWidth = 500;
  bool showDots = false;
  bool showDiagonal = true;
  // 是否正在滑动
  bool isSidesChange = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (MoonUtil.image == null) {
      MoonUtil.setImage(MoonUtil.imagePath, callBack: () {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (MoonUtil.image != null) {
      child = CustomPaint(painter: MoonPainter(progress: progress));
    } else {
      child = const Text('Loading...');
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: const Color(0xFF000000)),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: const Color(0xFF000000))
            ],
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: canvasWidth,
                      height: canvasWidth,
                      decoration: const BoxDecoration(),
                      clipBehavior: Clip.hardEdge,
                      child: child,
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      width: 500,
                      height: 20,
                      child: Slider.adaptive(
                        value: progress,
                        max: 4 * pi,
                        mouseCursor: SystemMouseCursors.basic,
                        activeColor: const Color(0xFF2C343A),
                        inactiveColor: const Color(0xFF56596B),
                        onChanged: (_value) {
                          updateSlider(_value, "onChanged : $_value",
                              isChange: true);
                        },
                        onChangeStart: (_value) {
                          updateSlider(_value, "onChangeStart : $_value",
                              isChange: true);
                        },
                        onChangeEnd: (_value) {
                          updateSlider(_value, "onChangeEnd : $_value");
                        },
                      ),
                    )
                  ]),
            ),
          ),
          Positioned(
            top: 100,
            left: 100,
            child: GestureDetector(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onTap: () {
                  NavigationUtil.instance.pop();
                }),
          ),
        ],
      ),
    );
  }

  void updateSlider(double _value, String text, {bool isChange = false}) {
    progress = _value;
    sliderText = text;
    isSidesChange = isChange;

    setState(() {});
  }
}
