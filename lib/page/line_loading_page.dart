import 'package:flutter/material.dart';
import 'package:polygon/painter/index.dart';
import 'package:polygon/util/index.dart';

class LineLoadingPage extends StatefulWidget {
  const LineLoadingPage({Key? key}) : super(key: key);
  static const String sName = "LineLoadingPage";
  @override
  State<LineLoadingPage> createState() => _LineLoadingPageState();
}

class _LineLoadingPageState extends State<LineLoadingPage> {
  double sides = 0;
  double progress = 0.0;
  double maxSides = 20.0;
  String sliderText = '0.0';
  double canvasWidth = 500;
  bool showDots = false;
  bool showDiagonal = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        painter: LineLoadingPainter(progress: sides),
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
                          print("sides:$sides");
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
    sides = _value;
    sliderText = text;
    setState(() {});
  }
}
