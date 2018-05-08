import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Demo'),
        ),
        body: new Center(
          child: new SimpleDemo(),
        ),
      ),
    ),
  );
}

class SimpleDemo extends StatelessWidget {
  /**
   * 弹出snackbar
   */
  _showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new SizedBox(
            child: new Text(
              'fadsdfsa',
            ),
          ),
          action: new SnackBarAction(
              label: 'label',
              onPressed: () {//点击事件
                Scaffold
                    .of(context)
                    .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
              }),
//              backgroundColor: Colors.green,
          duration: new Duration(seconds: 2),//显示的时间
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      onPressed: () {
        //点击事件
        _showSnackBar(context);
      },
      minWidth: 120.0,
      //最小宽度
      height: 50.0,
      //高度
      color: Colors.redAccent,
      //按钮的颜色
      splashColor: Colors.cyanAccent,
      //点击的颜色
      child: new Text('login'),
      //图标的文本
      elevation: 10.0, //立体高度
    );
  }
}
