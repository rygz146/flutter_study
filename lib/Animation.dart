import 'package:flutter/material.dart';

void main() {
  runApp(new FadeAppTest());
}

class FadeAppTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fade Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyFadeTest(title: 'Fade Demo'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State createState() => new _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curved;
  bool forward = true;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    curved = new CurvedAnimation(parent: controller, curve: Curves.bounceOut);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('FadeTest'),
      ),
      body: new Center(
//        child: new FadeTransition(//透明度动画
//          opacity: curved,
//          child: new FlutterLogo(
//            size: 200.0,
//          ),
//        ),
        child: new RotationTransition(//旋转动画
          turns: curved,
          child: new FlutterLogo(
            size: 200.0,
          ),
        ),

      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          if (forward)
            controller.forward();
          else
            controller.reverse();
          forward = !forward;
        },
        tooltip: 'fade',
        child: new Icon(Icons.track_changes),
      ),
    );
  }
}
