import 'package:flutter/material.dart';
import 'package:flutter_app/UIChallenge/DiageoalClipper.dart';
import 'package:flutter_app/UIChallenge/ListTask.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UIChanlleage',
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _ImageHeight = 256.0;

  Widget buildTopHeader() {
    return SafeArea(
      minimum: EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 32.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              'Timeline',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          new Icon(Icons.linear_scale, color: Colors.white),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }

  Widget buidPersonProfileRow() {
    return Padding(
      padding: EdgeInsets.only(top: _ImageHeight * 0.5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100.0,
          ),
          CircleAvatar(
              minRadius: 28.0,
              maxRadius: 28.0,
              backgroundImage: AssetImage('images/img3.jpg')),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Ryan Barnes',
                style: new TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              new Text(
                'Product designer',
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: _ImageHeight - 47,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Padding(
      padding: EdgeInsets.only(top: _ImageHeight),
      child: Column(
        children: <Widget>[
          _buildTaskHeard(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildTaskHeard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          'My Tasks',
          style: new TextStyle(fontSize: 34.0),
        ),
        new Text(
          'FEBRUARY 8, 2015',
          style: new TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ],
    );
  }
  void _changeFilterState(){
  showOnlyCompleted = !showOnlyCompleted;
  tasks.where((task)=>!task.completed).forEach((Task){
    if(showOnlyCompleted)
      listModel.removeAt(listModel.indexOf(Task));
    else
      listModel.insert(tasks.indexOf(Task), Task);
  });
  }
  Widget _buildFab() {
    return new Positioned(
      top: _ImageHeight - 36.0,
      right: 16.0,
      child: new FloatingActionButton(
        onPressed: _changeFilterState,
        backgroundColor: Colors.pink,
        child: new Icon(Icons.filter_list),
      ),
    );
  }
  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<AnimatedListState>();
  bool showOnlyCompleted = false;
  ListModel listModel;
  Widget _buildTasksList() {
    return Expanded(
      child: AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(listModel[index],animation);
        },
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Image.asset(
              'images/img1.jpg',
              width: MediaQuery.of(context).size.width,
              height: _ImageHeight,
              fit: BoxFit.fill,
              colorBlendMode: BlendMode.srcOver,
              color: new Color.fromARGB(125, 20, 10, 40),
            ),
            clipper: DiageonalClipper(),
          ),
          buildTopHeader(),
          buidPersonProfileRow(),
          _buildTimeline(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }
}
