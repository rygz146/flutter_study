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
          child: new SizedBox(
            child: new Container(
//              color: Colors.red,
              decoration: new BoxDecoration(
                color: Colors.lightBlueAccent
              ),
            ),
            width: 300.0,
            height: 200.0,
          ),
        ),
      ),
    ),
  );
}
