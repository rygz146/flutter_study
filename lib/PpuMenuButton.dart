import 'package:flutter/material.dart';

class BasicAppBarSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BasicAppBarSamplestate();
}

class _BasicAppBarSamplestate extends State<BasicAppBarSample> {
  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Basic Appbar'),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(choices[0].icon),
                onPressed: () {
                  _select(choices[0]);
                }),
            new IconButton(
                icon: new Icon(choices[1].icon),
                onPressed: () {
                  _select(choices[1]);
                }),
            new PopupMenuButton<Choice>(
              // overflow menu
              onSelected: _select,//Called when the user selects a value from the popup menu created by this button.
              itemBuilder: (BuildContext context) {
                return choices.skip(2).map((Choice choice) {
                  return new PopupMenuItem(
                      child: new Text(choice.title), value: choice);
                }).toList();
              },
            ),
          ],
        ),
        body: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ChoiceCard(
            choice: _selectedChoice,
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'bicycal', icon: Icons.directions_bike),
  const Choice(title: 'boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      elevation: 10.0,
      //高度 显示出立体感 立体阴影
      shape: new Border.all(
          color: Colors.red, width: 3.0, style: BorderStyle.solid),
      //图形边框
//      margin: const EdgeInsets.all(30.0),
      margin:
          new EdgeInsetsDirectional.only(bottom: 30.0, top: 10.0, start: 30.0),
      //边距
      color: Colors.white,
      child: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              choice.icon,
              size: 128.0,
              color: textStyle.color,
            ),
            new Text(choice.title),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new BasicAppBarSample());
}
