import 'package:flutter/material.dart';
import 'NavigationIconView.dart';

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //拿到当前主题的数据
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      decoration: new BoxDecoration(
        color: iconTheme.color,
      ),
    );
  }
}

//创建一个有状态的菜单demo
class MenusDemo extends StatefulWidget {
  @override
  _MenusDemoState createState() => new _MenusDemoState();
}

//TickerProviderStateMixin 提供一个Ticker
class _MenusDemoState extends State<MenusDemo> with TickerProviderStateMixin {
  int _currentIndex = 2; //默认当前底部按钮位置为2
  BottomNavigationBarType _type =
      BottomNavigationBarType.shifting; //默认底部导航类型shifting
  List<NavigationIconView> _navigationIconViews; //底部导航图标list
  //Called when this object is inserted into the tree.
  @override
  void initState() {
    super.initState(); //需要调用父类的initstate
    //初始化数组
    _navigationIconViews = <NavigationIconView>[
      new NavigationIconView(
          icon: new Icon(Icons.directions_railway),
          title: new Text('美女'),
          color: Colors.redAccent[500],
          vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.access_alarm),
          title: new Text('美女'),
          color: Colors.blue[500],
          vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.access_alarm),
          title: new Text('美女'),
          color: Colors.blue[500],
          vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.access_alarm),
          title: new Text('美女'),
          color: Colors.blue[500],
          vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.access_alarm),
          title: new Text('美女'),
          color: Colors.blue[500],
          vsync: this),
//      new NavigationIconView(
//          icon: new Icon(Icons.access_alarm),
//          title: new Text('美女'),
//          color: Colors.blue[500],
//          vsync: this),
    ];
    for (NavigationIconView view in _navigationIconViews)
      /**
       * //给每个一设置动画监听器，每当动画的值发生变化时，就调用监听器。
       * 然后调用setstate重新绘制。
       */
      view.controller.addListener(_rebuild);
    /**
     *  curve: new Interval(0.1, 1.0, curve: Curves.fastOutSlowIn));
     *  Stops the animation controller and sets the current value of the animation.
        The new value is clamped to the range set by [lowerBound] and [upperBound].
        Value listeners are notified even if this does not change the value. Status
        listeners are notified if the animation was previously playing.
        The most recently returned [TickerFuture], if any, is marked as having
        been canceled, meaning the future never completes and
        its [TickerFuture.orCancel] derivative future completes with a [TickerCanceled] error.
     */
    _navigationIconViews[_currentIndex].controller.value =
        1.0; //设置当前value为1，范围0.1 -1
  }

  /**
   * 当这个对象被永久地从树中移除时调用。
   * 移除时移除动画controller
   */
  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationIconViews)
      view.controller.dispose();
  }

  void _rebuild() {
    setState(() {});
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];
    for (NavigationIconView view in _navigationIconViews)
      transitions.add(view.transition(_type, context));

    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      double aValues = aAnimation.value;
      double bValues = bAnimation.value;
      return aValues.compareTo(bValues);
    });
    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      fixedColor: Colors.blue,
      items: _navigationIconViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationIconViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationIconViews[_currentIndex].controller.forward();
        });
      },
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('底部导航演示'),
        actions: <Widget>[
          new PopupMenuButton(
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<BottomNavigationBarType>>[
                  new PopupMenuItem(
                    child: new Text('Fixed'),
                    value: BottomNavigationBarType.fixed,
                  ),
                  new PopupMenuItem(
                    child: new Text('shifting'),
                    value: BottomNavigationBarType.shifting,
                  )
                ],
            onSelected: (BottomNavigationBarType value) {
              setState(() {
                _type = value;
              });
            },
          )
        ],
      ),
      body: new Center(
        child: _buildTransitionsStack(),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'aaaa累死了',
    home: new MenusDemo(),
  ));
}
