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
          child: new Container(
//            color: Colors.red,
            child: new AspectRatio(
              aspectRatio:3/2, //横纵比 长宽比  3:2
              child: new Image(image: new AssetImage('images/img1.jpg')),
            ),
          ),
        ),
      ),
    ),
  );
}
