import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Demo',
      home: new Simple(),
    ),
  );
}

class Simple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TEst',
      home: new SimpleAppPage(),
    );
  }
}

class SimpleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SimpleAppPageState();
}

class SimpleAppPageState extends State<SimpleAppPage> {
  int _count = 2;

  void _upDateText() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('jtitle'),
      ),
      body: new Center(
        child: new Text(
          '$_count',
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add), onPressed: _upDateText),
      drawer: new DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
          child: new SizedBox(
            height: 100.0,
            width: 200.0,
            child: new Icon(Icons.sort),
          )),
    );
  }
}
