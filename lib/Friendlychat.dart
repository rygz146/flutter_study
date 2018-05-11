import 'package:flutter/material.dart';

void main() {
  runApp(new FriendlyChatApp());
}
///主聊天界面
class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Friendlychat',
      home: new ChatScreen(),
    );
  }
}
///主屏幕
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => new _ChatScreenState();
}
///TickerProviderStateMixin 提供
class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  ///存放单挑消息widget
  List<ChatMessage> _message = <ChatMessage>[];
  ///文本输入控制
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextCompset() {///文本输入的组合包含一个输入框和一个按钮
    ///让所有的控件都使用设定的主题
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(///自动使用屏幕剩余空间填充
                child: new TextField(//输入框
                  controller: _textController,
                  onSubmitted: _handleSubmitted,//Called when the user indicates that they are done editing the text in the field.
                  decoration:
                      new InputDecoration.collapsed(hintText: 'Send a message'),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(///发送按钮
                    icon: new Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Friendlychat'),
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemBuilder: (_, int) => _message[int],
              padding: new EdgeInsets.all(8.0),
              itemCount: _message.length,
              ///
              reverse: true,
            ),
          ),
          _buildTextCompset(),
        ],
      ),
    );
  }

  _handleSubmitted(String text) {///处理提交文本
    _textController.clear();
    var chatMessage = new ChatMessage(///实例化一个消息条目widget
      _message.length,
      text: text,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 200)),
    );
    setState(() {
      _message.insert(0, chatMessage);///将消息条目插入到消息条目list，并更新状态
    });
      chatMessage.animationController.forward();//播放动画
  }
}



class ChatMessage extends StatelessWidget {//单个消息条目
  ///your name
   String _name = 'TANGBO';

  ChatMessage(this.index, {this.text, this.animationController})
      : assert(index != null);
  final AnimationController animationController;
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      axis:Axis.vertical ,
//      axisAlignment:0.5 ,
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          mainAxisAlignment:
              index % 2 == 1 ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.all(5.0),
              child: new CircleAvatar(
                child: new Text(_name[0]),
              ),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  _name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                ),
                new Divider(
                  height: 4.0,
                  color: Colors.black,
                  indent: 10.0,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
