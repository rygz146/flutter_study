import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new FrostedDemo()));
}

class FrostedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
//              child: Image.asset('images/img4.jpg'),
          ),
          new Center(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 6.0, sigmaY:6.0),
                child: new Container(
                  width: 400.0,
                  height: 700.0,
                  decoration: new BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new Center(
                    child: new Text(
                        'Frosted',
                        style: Theme.of(context).textTheme.display3
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}