/*
*
*
* Plan Dropped
*
*
*   */

import 'package:flutter/material.dart';
//import 'package:scribbly/Components/MyroundButtons.dart';

class MySlider extends StatefulWidget {
  Function funct;
  double value__;

  MySlider({this.value__, this.funct});

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double dum = 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Slide to Increase Pen Size",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w900,
                  fontSize: 23.0),
            ),
            SizedBox(
              height: 20,
            ),
            Slider(
//                value: strokeSize,
//              value: widget.value__,
              value: dum,
              min: 2,
              max: 10,
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
//                onChanged: widget.funct
              onChanged: (double x) {
                dum = x;
                widget.value__ = dum;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Pen Size ${widget.value__.toInt().toString()}",
              style: TextStyle(color: Colors.blueAccent),
            ),
            RaisedButton(
              onPressed: () {
                print(widget.value__);
              },
              child: Text("clickme"),
            )
          ],
        ),
      ),
    );
  }
}
