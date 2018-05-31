import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Animation/bar.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const size = const Size(20.0, 100.0);
  final random = new Random();
  AnimationController animation;
  BarCharTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    // Tween({T begin, T end })：创建tween（补间）
    tween = new BarCharTween(
        new BarChart.empty(), new BarChart.random(size, random));
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      tween = new BarCharTween(
        tween.evaluate(animation),
        new BarChart.random(size, random),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new CustomPaint(
              size: new Size(400.0, 100.0),
              painter: new BarChartPainter(tween.animate(animation)))),
      floatingActionButton: new FloatingActionButton(
        onPressed: changeData,
        child: new Icon(Icons.refresh),
      ),
    );
  }
}
