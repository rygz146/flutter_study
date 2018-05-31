import 'dart:math';

import 'package:flutter/material.dart';

class ColorPalette {
  static final ColorPalette primary = new ColorPalette(<Color>[
    Colors.blue[400],
    Colors.red[400],
    Colors.green[400],
    Colors.yellow[400],
    Colors.purple[400],
    Colors.orange[400],
    Colors.teal[400],
  ]);

  ///构造方法,传入一个颜色数组
  ColorPalette(List<Color> colors) : _colors = colors {
    assert(colors.isNotEmpty);
  }

  ///颜色数组
  final List<Color> _colors;

  ///自定义操作符[],返回一个在数组中的颜色
  Color operator [](int index) => _colors[index % length];

  ///get方法,返回颜色数组的大小
  int get length => _colors.length;

  ///随机返回一个颜色
  Color random(Random random) => this[random.nextInt(length)];
}
