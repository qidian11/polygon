import 'package:flutter/material.dart';
import 'package:polygon/painter/index.dart';
import 'package:polygon/util/index.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({Key? key}) : super(key: key);
  static const String sName = "PaperPage";
  @override
  State<PaperPage> createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage>
    with SingleTickerProviderStateMixin {
  // late Animation<double> _animation;
  // late Tween<double> _tween;
  // late AnimationController _animationController;
  double progress = 0;

  String sliderText = '0.0';
  double canvasWidth = 300;
  double canvasHeight = 400;
  double maxSides = 300;
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
                      height: canvasHeight,
                      decoration: const BoxDecoration(),
                      clipBehavior: Clip.hardEdge,
                      child: CustomPaint(
                        painter: PaperPainter(progress: progress),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      width: 500,
                      height: 20,
                      child: Slider.adaptive(
                        value: progress,
                        max: maxSides,
                        mouseCursor: SystemMouseCursors.basic,
                        activeColor: const Color(0xFF2C343A),
                        inactiveColor: const Color(0xFF56596B),
                        onChanged: (_value) {
                          print("sides:$progress");
                          print("onChanged : $_value");
                          updateSlider(_value, "onChanged : $_value",
                              isChange: true);
                        },
                        onChangeStart: (_value) {
                          print("onChangeStart : $_value");
                          updateSlider(_value, "onChangeStart : $_value",
                              isChange: true);
                        },
                        onChangeEnd: (_value) {
                          print("onChangeEnd : $_value");
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
    progress = _value;
    setState(() {});
  }
}
