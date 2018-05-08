import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      body: new Center(
        child: new Container(
          child: new CachedNetworkImage(
            imageUrl:
            'http://h.hiphotos.baidu.com/image/pic/item/21a4462309f790525fe7185100f3d7ca7acbd5e1.jpg',
            placeholder:
            new Image.network('http://via.placeholder.com/350x150'),
          ),
        ),
//        child: new ExampleWidget(),
      ),
    ),
  ));
}

/**
 * 输入文本获取字符
 */
class ExampleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ExampleWidgetState();
}

class ExampleWidgetState extends State<ExampleWidget> {
  String inputString = null;

  _change(String s) => inputString = s;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new TextField(
          onChanged: _change,
        ),
        new MaterialButton(onPressed: () {
          setState(() {});
        }),
        new Text('$inputString'),
      ],
    );
  }
}
