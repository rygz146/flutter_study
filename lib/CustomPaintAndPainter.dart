import 'package:flutter/material.dart';

/**
 * 通过继承CustomPainter 自定义一个空间
 */
class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points; // Offset:一个不可变的2D浮点偏移。

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint() //设置笔的属性
      ..color = Colors.blue[200]
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 12.0

    ..strokeJoin = StrokeJoin.bevel;

    for (int i = 0; i < points.length - 1; i++) {
      //画线
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1],
            paint); //drawLine(Offset p1, Offset p2, Paint paint) → void
//      canvas.drawOval(
//          new Rect.fromCircle(center: points[i], radius: 20.0), paint);
////      canvas.drawOval(rect, paint)
//    canvas.drawCircle(points[i], 20.0, paint);
    }
  }

  /**
   * 是否重绘
   */
  bool shouldRepaint(SignaturePainter other) => other.points != points;
//  bool shouldRepaint(SignaturePainter other) =>true;
}

class Signature extends StatefulWidget {
  SignatureState createState() => new SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return new Stack(
      children: [
        GestureDetector(

          onPanUpdate: (DragUpdateDetails details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);
            setState(() {
              _points = new List.from(_points)..add(localPosition);
//              _points.add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),

        ),

        CustomPaint(painter: new SignaturePainter(_points))
      ],
    );
  }
}

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) => new Scaffold(body: new Signature());
}

void main() => runApp(new MaterialApp(home: new DemoApp()));
