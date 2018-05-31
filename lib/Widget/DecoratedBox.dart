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
          child: new DecoratedBox(
            decoration: new BoxDecoration(
              gradient: new RadialGradient(
                  colors: [Colors.redAccent, Colors.amberAccent],
                  radius: 3.0), //1.0 100pix
            ),
            child: new Text(
              'hahhahahahahha',
              style: new TextStyle(fontSize: 50.0),
            ),
          ),
        ),
      ),
    ),
  );
}
