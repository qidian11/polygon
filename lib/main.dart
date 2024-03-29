import 'dart:io';
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

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  double frameBorderWidth = 8.0;
  int crossAxisCount = 3;
  Offset frameShadowOffset = const Offset(10, 0);
  double crossAxisSpacing = 100;
  double width = 0;
  double height = 0;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
      crossAxisSpacing = 20;
    }
    width = (MediaQuery.of(context).size.width -
            (crossAxisCount + 1) * crossAxisSpacing) /
        crossAxisCount;
    height = width;
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    width = (MediaQuery.of(context).size.width -
            (crossAxisCount + 1) * crossAxisSpacing) /
        crossAxisCount;
    height = width;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = (MediaQuery.of(context).size.width -
            (crossAxisCount + 1) * crossAxisSpacing) /
        crossAxisCount;
    List<Widget> widgets = [];
    for (int i = 0; i < CommonUtil.pageList.length; i++) {
      widgets.add(FrameWidget(index: i, width: width));
    }
    // List<Widget> widgets = List.generate(CommonUtil.pageList.length, (index) {
    //   return FrameWidget(index: index, width: width);
    // });
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

  List<Widget> getWidgets(double width) {
    List<Widget> widgets = [];
    for (int i = 0; i < CommonUtil.pageList.length; i++) {
      widgets.add(FrameWidget(index: i, width: width));
    }
    // List<Widget> widgets = List.generate(CommonUtil.pageList.length, (index) {
    //   return FrameWidget(index: index, width: width);
    // });
    return widgets;
  }
}
