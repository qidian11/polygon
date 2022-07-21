import 'package:flutter/material.dart';
import 'package:polygon/painter/index.dart';
import 'package:polygon/util/index.dart';
import 'package:polygon/widget/index.dart';

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double frameBorderWidth = 8.0;
  int crossAxisCount = 3;
  Offset frameShadowOffset = const Offset(10, 0);
  double crossAxisSpacing = 100;
  late double width;
  late double height;
  double progress = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    width = (MediaQuery.of(context).size.width -
            (crossAxisCount + 1) * crossAxisSpacing) /
        crossAxisCount;
    height = width;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = getWidgets();
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(crossAxisSpacing),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 25.0,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: 1),
        children: widgets,
      ),
    );
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = List.generate(CommonUtil.pageList.length, (index) {
      return FrameWidget(index: index, width: width);
    });
    return widgets;
  }
}
