import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Animation/color_palette.dart';

class BarChart {
  ///bar LIst
  final List<Bar> bars;

  ///构造方法 传入一个list<Bar>
  BarChart(this.bars);

  ///创建空的bar 高度为零 颜色透明
  factory BarChart.empty() {
    return new BarChart(<Bar>[]);
  }
  ///创建一个Barchart个一个尺寸  传入一个随机
  factory BarChart.random(Size size, Random random) {
    ///宽度占比
    const barWidthFraction = 0.75;
    ///最小距离
    const minBarDistance = 20.0;
    // floor()：返回不大于此的最大整数
    //返回一个条目数量
    final barCount = random.nextInt((size.width / minBarDistance).floor()) + 1;
    final barDistance = size.width / (1 + barCount);
    final barWidth = barDistance * barWidthFraction;
    final startX = barDistance - barWidth / 2;
    final color = ColorPalette.primary.random(random);

    final bars = new List.generate(
      barCount,
      (i) => new Bar(
            startX + i * barDistance,
            barWidth,
            random.nextDouble() * size.height,
            color,
          ),
    );
    return new BarChart(bars);
  }

  ///BarChart线性插值 返回一个barchart
  static BarChart lerp(BarChart begin, BarChart end, double t) {
    final barCount = max(begin.bars.length, end.bars.length);
    final bars = new List.generate(
        barCount,
        (i) => Bar.lerp(
              begin._barOrNull(i) ?? end.bars[i].collapsed,
              end._barOrNull(i) ?? begin.bars[i].collapsed,
              t,
            ));
    return new BarChart(bars);
  }

  Bar _barOrNull(int index) => (index < bars.length ? bars[index] : null);
}

class BarCharTween extends Tween<BarChart> {
  BarCharTween(BarChart begin, BarChart end) : super(begin: begin, end: end);

  @override
  BarChart lerp(double t) => BarChart.lerp(begin, end, t);
}

class Bar {
  Bar(this.x, this.width, this.height, this.color);

  final double x;
  final double width;
  final double height;
  final Color color;
  //返回一个空的collapsed bar
  Bar get collapsed => new Bar(x, 0.0, 0.0, color);

  static Bar lerp(Bar begin, Bar end, double t) {
    return new Bar(
        lerpDouble(begin.x, end.x, t),
        lerpDouble(begin.width, end.width, t),
        lerpDouble(begin.height, end.height, t),
        Color.lerp(begin.color, end.color, t));
  }
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin, end, t);
}

class BarChartPainter extends CustomPainter {
  ///默认条形宽度为10
  static const barWidthFraction = 0.75;

  BarChartPainter(Animation<BarChart> animation)
      : animation = animation,
        super(repaint: animation);

  final Animation<BarChart> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()..style = PaintingStyle.fill;
    final chart = animation.value;
    for (final bar in chart.bars) {
      paint.color = bar.color;
      canvas.drawRect(
          new Rect.fromLTWH(
              bar.x, size.height - bar.height, bar.width, bar.height),
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
