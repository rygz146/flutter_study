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
          child: new Stack(//第一个子控件最下面
            alignment: new Alignment(0.6, 0.6),
            //statck
            children: <Widget>[
              new Align(
                alignment: FractionalOffset.center,
//          heightFactor: 40.0,
//          widthFactor: 40.0,
                child: new Image.network(//加载网络图片
                  'http://h.hiphotos.baidu.com/image/pic/item/21a4462309f790525fe7185100f3d7ca7acbd5e1.jpg',
                  height: 300.0,
                  width: 300.0,
                  repeat: ImageRepeat.repeat,//图片重复方式
                ),
              ),
              new Opacity(
                opacity: 0.5,//不透明度
                child: new Container(
                  width: 300.0,
                  height: 400.0,
                  color: Colors.blue,
                ),
              ),
              new Opacity(
                opacity: 0.3,
                child: new Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
