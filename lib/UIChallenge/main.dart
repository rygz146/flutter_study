import 'dart:math' as math;

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

  Widget _buildTopHeader() {
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

  Widget _buidPersonProfileRow() {
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

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted; //是否只是展示完成了的
    tasks.where((task) => !task.completed).forEach((Task) {
      if (showOnlyCompleted) //把没完成的去掉
        listModel.removeAt(listModel.indexOf(Task));
      else //把没完成的插入
        listModel.insert(tasks.indexOf(Task), Task);
    });
  }

  Widget _buildFab() {
    return new Positioned(
        top: _ImageHeight - 100.0,
        right: -40.0,
        child: AnimatedFab(
          onClick: _changeFilterState,
        ));
  }

  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  bool showOnlyCompleted = false;
  ListModel listModel;

  Widget _buildTasksList() {
    return Expanded(
      child: AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(listModel[index], animation);
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
          _buildTopHeader(),
          _buidPersonProfileRow(),
          _buildTimeline(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }
}

class AnimatedFab extends StatefulWidget {
  VoidCallback onClick;

  AnimatedFab({Key key, this.onClick}) : super(key: key);

  @override
  _AnimatedFabState createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController _animatinController;
  Animation<Color> _colorAnimation;
  final double expandSize = 180.0;
  final double hiddenSize = 20.0;

  @override
  void initState() {
    super.initState();
    _animatinController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animatinController);
  }

  @override
  void dispose() {
    super.dispose();
    _animatinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expandSize,
      height: expandSize,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget child) {
          return Stack(
            children: <Widget>[
              BuildExpandBackground(),
              _buildOption(Icons.check_circle, 0.0),
              _buildOption(Icons.flash_on, -math.pi / 4),
              _buildOption(Icons.menu, -2 * math.pi / 4),
              _buildOption(Icons.access_time, -3 * math.pi / 4),
              _buildOption(Icons.error_outline, math.pi),
              BuildFab(),
            ],
            alignment: Alignment.center,
          );
        },
        animation: _animatinController,
      ),
    );
  }

  Widget BuildFab() {
    double scaleFator = 2 * (_animatinController.value - 0.5).abs();
    return FloatingActionButton(
      onPressed: _onFabTap,
      child: Transform(
        alignment: Alignment.center,
        child: Icon(
            _animatinController.value > 0.5 ? Icons.close : Icons.filter_list),
        transform: Matrix4.identity()..scale(scaleFator, scaleFator), //单位矩阵
      ),
      backgroundColor: _colorAnimation.value,
    );
  }

  Widget BuildExpandBackground() {
    double size =
        hiddenSize + (expandSize - hiddenSize) * _animatinController.value;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget _buildOption(IconData icon, double angle) {
    double iconSize = 0.0;
    if (_animatinController.value > 0.8) {
      iconSize = 26.0 * (_animatinController.value - 0.8) * 5;
    }
    return Transform.rotate(
      angle: angle,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: IconButton(
              icon: Transform.rotate(
                angle: -angle,
                child: new Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              iconSize: iconSize,
              alignment: Alignment.center,
              onPressed: () {
                _onIconClick();
              },
            )),
      ),
    );
  }

  _onIconClick() {
    widget.onClick();
    close();
  }

  open() {
    if (_animatinController.isDismissed) {
      _animatinController.forward();
    }
  }

  close() {
    if (_animatinController.isCompleted) {
      _animatinController.reverse();
    }
  }

  _onFabTap() {
    if (_animatinController.isDismissed)
      open();
    else
      close();
  }
}
