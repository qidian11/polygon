import 'package:flutter/material.dart';
import 'package:polygon/painter/index.dart';
import 'package:polygon/util/index.dart';

class PerlinNoise2dPage extends StatefulWidget {
  const PerlinNoise2dPage({Key? key}) : super(key: key);
  static const String sName = "PerlinNoisePage2d";
  @override
  State<PerlinNoise2dPage> createState() => _PerlinNoise2dPageState();
}

class _PerlinNoise2dPageState extends State<PerlinNoise2dPage>
    with SingleTickerProviderStateMixin {
  // late Animation<double> _animation;
  // late Tween<double> _tween;
  // late AnimationController _animationController;
  double sides = 0;
  double progress = 0.0;
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
    // _tween = Tween(begin: 0.0, end: 1.0);
    // _animationController =
    //     AnimationController(duration: const Duration(seconds: 60), vsync: this);
    // _animation = _tween.animate(_animationController)
    //   ..addListener(() {
    //     setState(() {
    //       progress = _animation.value;
    //     });
    //   })
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       _animationController.reverse();
    //     }
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                color: const Color(0xFFE9EFF2),
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: const Color(0xFFD3DBDF))
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
                      child: CustomPaint(
                        painter: PerlinNoise2dPainter(progress: sides),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      width: 500,
                      height: 20,
                      child: Slider.adaptive(
                        value: sides,
                        max: 200,
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
                child: Icon(Icons.arrow_back),
                onTap: () {
                  NavigationUtil.instance.pop();
                }),
          ),
        ],
      ),
    );
  }

  void updateSlider(double _value, String text, {bool isChange = false}) {
    sides = _value;
    sliderText = text;
    isSidesChange = isChange;
    setState(() {});
  }
}
