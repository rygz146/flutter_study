import 'package:flutter/material.dart';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SampleApp',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new SampleDemo(),
    );
  }
}

class SampleDemo extends StatefulWidget {
  SampleDemo({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new SimpleDemoState();
}

class SimpleDemoState extends State<SampleDemo> {
  bool toggle = false;

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getChild() {
    if (toggle)
      return new Text('开 文本');
    else
      return new MaterialButton(
        onPressed: () {},
        height: 20.0,
        minWidth: 50.0,
        color: Colors.cyanAccent,
        child: new Text('关  按钮'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sampless APp'),
      ),
      body: new Center(
        child: _getChild(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _toggle,
        child: new Icon(Icons.cached),
      ),
    );
  }
}

