import 'package:flutter/material.dart';

//Drawing place is the class for storing each and every scribble
class Drawingplace {
  Offset point;
  Paint drawingarea;
  Drawingplace({this.drawingarea, this.point});
}

class DrawPad extends CustomPainter {
  // Its the list of instances that will contain the properties of each scribble
  List<Drawingplace> points = [];
  DrawPad({
    this.points,
  });
  @override
  void paint(Canvas canvas, Size size) async {
    Paint bgcolor = Paint();
    bgcolor.color = Colors.white;
    Rect pad = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(pad, bgcolor);
    try {
      for (int pts = 0; pts < points.length - 1; pts++) {
        if (points[pts] != null && points[pts + 1] != null) {
          //For each scribble separate paint object is created during the panUpdate and panstart.
          Paint paint = points[pts].drawingarea;
          canvas.drawLine(points[pts].point, points[pts + 1].point, paint);
        } else if (points[pts] != null && points[pts + 1] == null) {
          Paint paint = points[pts].drawingarea;
          canvas.drawCircle(points[pts].point, 1, paint);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
