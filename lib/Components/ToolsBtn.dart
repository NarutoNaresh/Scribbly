import 'package:flutter/material.dart';
import 'package:scribbly/Components/MyroundButtons.dart';

class BtnFunction extends StatelessWidget {
  double topdist, Strokesize, btnht;
  Icon icons;
  Color btnclr;
  Function onclick;

  final AnimationController controller;
  BtnFunction(
      {this.topdist,
      this.icons,
      this.btnclr,
      this.onclick,
      this.controller,
      this.Strokesize,
      this.btnht});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: btnht - topdist * controller.value,
      right: 20,
      child: ScaleTransition(
        scale: controller,
        child: MyroundButtons(
          onclick: onclick,
          width: 50,
          ico: icons,
          btnclr: btnclr,
        ),
      ),
    );
  }
}
