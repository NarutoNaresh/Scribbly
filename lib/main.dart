import 'package:flutter/material.dart';
import 'package:scribbly/Home.dart';

void main() => runApp(Scribbly());

class Scribbly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}
