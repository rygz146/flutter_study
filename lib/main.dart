import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/semantics.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Demo'),
        ),
        body: new Center(
            child: new CustomPaint(
          painter: new Sky(),
          child: new Center(
            child: new Text(
              'Once upon a time...',
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        )),
      ),
    ),
  );
}

 class Sky extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
     var rect = Offset.zero & size;
     var gradient = new RadialGradient(
       center: const Alignment(0.7, -0.6),
       radius: 0.2,
       colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
       stops: [0.4, 0.8],
     );
     canvas.drawRect(
       rect,
       new Paint()..shader = gradient.createShader(rect),//gradient 渐变
     );
   }

   @override
   SemanticsBuilderCallback get semanticsBuilder {
     return (Size size) {
       // Annotate a rectangle containing the picture of the sun
       // with the label "Sun". When text to speech feature is enabled on the
       // device, a user will be able to locate the sun on this picture by
       // touch.
       var rect = Offset.zero & size;
       var width = size.shortestSide * 0.4;
       rect = const Alignment(0.8, -0.9).inscribe(new Size(width, width), rect);
       return [
         new CustomPainterSemantics(
           rect: rect,
//           properties:
         properties: new SemanticsProperties(
                          label: 'Sun',
                          textDirection: TextDirection.ltr,
                       ),
         ),
       ];
     };
   }

   // Since this Sky painter has no fields, it always paints
   // the same thing and semantics information is the same.
   // Therefore we return false here. If we had fields (set
   // from the constructor) then we would return true if any
   // of them differed from the same fields on the oldDelegate.
   @override
   bool shouldRepaint(Sky oldDelegate) => false;
   @override
   bool shouldRebuildSemantics(Sky oldDelegate) => false;
 }
