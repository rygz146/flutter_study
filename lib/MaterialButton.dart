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
  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      onPressed: () {
        Scaffold.of(context).showSnackBar(new SnackBar(
              content: new SizedBox(
                child: new Text(
                  'fadsdfsa',
                ),
              ),
              action: new SnackBarAction(label: 'hehee', onPressed:(){
                Scaffold.of(context).hideCurrentSnackBar(reason:SnackBarClosedReason.hide );
              } ),
//              backgroundColor: Colors.green,
          duration: new Duration(seconds: 2),
            ));
      },
      minWidth: 120.0,
      height: 50.0,
      color: Colors.redAccent,
      splashColor: Colors.cyanAccent,
    );
  }
}
