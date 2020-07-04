import 'package:flutter/material.dart';

class MyroundButtons extends StatelessWidget {
  Icon ico;
  double height, width;
  Function onclick;
  Color btnclr;
  MyroundButtons(
      {this.btnclr, this.ico, this.onclick, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: btnclr, borderRadius: BorderRadius.circular(30)),
      width: width,
      height: height,
      child: IconButton(
        icon: ico,
        onPressed: onclick,
        enableFeedback: true,
      ),
    );
  }
}
