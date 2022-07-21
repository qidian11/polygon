import 'package:flutter/material.dart';
import 'package:polygon/painter/index.dart';
import 'package:polygon/util/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: CommonUtil.navigatorKey,
      routes: NavigationUtil.configRoutes,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double frameBorderWidth = 8.0;
  Offset frameShadowOffset = const Offset(10, 0);
  double crossAxisSpacing = 50;
  late double width;
  late double height;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    width = (MediaQuery.of(context).size.width - 3 * crossAxisSpacing) / 2;
    height = width;
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    List<Widget> widgets = getWidgets();
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(50),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 25.0,
            crossAxisSpacing: 50,
            childAspectRatio: 1),
        children: widgets,
      ),
    );
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = List.generate(CommonUtil.pageList.length, (index) {
      CustomPainter? painter =
          CommonUtil.page2painter[CommonUtil.pageList[index]];
      if (painter != null) {
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
                width: 3 * width / 5,
                height: 3 * height / 4,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color(0xFF2C343A),
                        width: frameBorderWidth),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF2C343A).withOpacity(0.78),
                          offset: frameShadowOffset,
                          blurRadius: 5)
                    ]),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  child: CustomPaint(painter: painter),
                ),
              ),
            ),
          ),
        );
      } else {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFD3DBDF),
          ),
          child: Center(
            child: Container(
              width: 3 * width / 5,
              height: 3 * height / 4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: const Color(0xFF2C343A), width: frameBorderWidth),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF2C343A).withOpacity(0.78),
                        offset: frameShadowOffset,
                        blurRadius: 5)
                  ]),
            ),
          ),
        );
      }
    });
    return widgets;
  }
}
