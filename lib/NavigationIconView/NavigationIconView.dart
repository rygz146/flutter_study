import 'package:flutter/material.dart';

/**
 * 导航图标View
 */
class NavigationIconView {
  NavigationIconView({
    //widget图标
    Widget icon,
    //widget标题
    Widget title,
    //颜色
    Color color,
    //每帧同步，提供一个Ticker ,通常被用作动画
    TickerProvider vsync,
  })  : _icon = icon,//接收图标widget
        _color = color,//颜色
        item = new BottomNavigationBarItem(icon: icon, title: title),//底部导航条目
  //创建一个动画控制器 kThemeAnimationDuration  在默认情况下，主题更改为动画的持续时间
        controller = new AnimationController(
            vsync: vsync, duration: kThemeAnimationDuration) {
    _animation = new CurvedAnimation(
        parent: controller,
        curve: new Interval(0.1, 1.0, curve: Curves.fastOutSlowIn));
  }

  final Widget _icon;
  final Color _color;
  final BottomNavigationBarItem item;//底部导航条目
  final AnimationController controller;
  CurvedAnimation _animation;//一种将曲线应用于另一个动画的动画。
  //淡入淡出小部件
  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;//图标的颜色,根据底部导航按钮类型确定颜色
    if (type == BottomNavigationBarType.shifting) {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
//      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }
    return new FadeTransition(
      opacity: _animation,//不透明度
      // 创建一个不透明的过渡。
      child: new IconTheme(//创建一个图标主题，控制后代小部件的颜色、不透明度和大小。
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: _icon),
    );
  }
}
