import 'package:flutter/material.dart';

class Clrbtmsht extends StatelessWidget {
  Function onclicking;
  Function onclick;
  Clrbtmsht({this.onclicking, this.onclick});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Color(0xff757575),
          border: Border(
            left: BorderSide(color: Colors.black, width: 4.7),
            right: BorderSide(color: Colors.black, width: 4.7),
          )),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Select Any Option",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w900,
                  fontSize: 23.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Color Palette"),
                  onPressed: onclicking,
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  child: Text("More colors"),
                  onPressed: onclick,
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
