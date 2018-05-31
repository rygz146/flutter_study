import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(new MaterialApp(
    home: new SampleAppPage(),
  ));
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadDate();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SampleAppage'),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext, int) {
          return new ListTile(
            dense: false,
            title: new Text(
              '${widgets[int]["title"]}',
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            subtitle: new Text(
              '${widgets[int]["body"]}',
              maxLines: 1,
            ),
            trailing: new Text('trailing'),
            leading: new CircleAvatar(
              child: new Text('${widgets[int]["id"]}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        },
      ),
    );
  }

  Widget getRow(int i) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(5.0),
          child: new Text('${widgets[i]["title"]}'),
        ),
        new Divider(
          indent: 10.0,
          height: 10.0,
          color: Colors.blue,
        ),
      ],
    );
  }

  loadDate() async {
    String dateUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dateUrl);
    print(response.statusCode);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
