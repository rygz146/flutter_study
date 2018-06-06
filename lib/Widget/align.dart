import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'align',
      home: new Scaffold(
          body: new Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Text('fdsafads'),
              ),
            ],
          ),
          new Align(
            alignment: const FractionalOffset(0.5, 1.0),
            //偏移小数最大（1.0,1.0）  (0.0,0.0)左上角 （1.0,1.0）右下角
//          heightFactor: 40.0,
//          widthFactor: 40.0,
            child: new Image.network(
              'http://h.hiphotos.baidu.com/image/pic/item/21a4462309f790525fe7185100f3d7ca7acbd5e1.jpg',
              height: 400.0,
              width: 400.0,
//              repeat: ImageRepeat.repeat,
            ),
          ),
          new Align(
            alignment: FractionalOffset.center,
//          heightFactor: 40.0,
//          widthFactor: 40.0,
            child: new Image.network(
              'http://b.hiphotos.baidu.com/image/pic/item/eaf81a4c510fd9f95e3fd930292dd42a2834a4bb.jpg',
              height: 400.0,
              width: 400.0,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
        ],
      )),
    ),
  );
}
