import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scribbly/Components/ColorBottomSheet.dart';
import 'package:scribbly/Components/DrawingPad.dart';
import 'package:scribbly/Components/MyroundButtons.dart';
import 'package:scribbly/Components/ToolsBtn.dart';

class Mypainting extends StatefulWidget {
  @override
  _MypaintingState createState() => _MypaintingState();
}

//Global variables
Color clr = Colors.black;
Color sliderClr = Colors.black;
double ddd = 2.0;
List<Drawingplace> pts = [];

class _MypaintingState extends State<Mypainting>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  double strokeSize = 2.0;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInQuart);
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
//Color picker
    void selectColor() {
      showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: clr,
              onColorChanged: (color) {
                setState(() {
                  clr = color;
                  sliderClr = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Terminate"))
          ],
        ),
      );
    }

    void selectColor2() {
      showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
              child: ColorPicker(
            pickerAreaBorderRadius: BorderRadius.all(Radius.circular(30)),
            enableAlpha: false,
            pickerColor: clr,
            onColorChanged: (color) {
              setState(() {
                clr = color;
                sliderClr = color;
              });
            },
          )),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Terminate"))
          ],
        ),
      );
    }

//    print("width is $width");
//    print(height);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: width * 1,
              height: height * 0.9,
              //Gesture detector listens the offset values(positons on the screen)
              child: GestureDetector(
                onPanUpdate: (detail) {
                  setState(() {
                    //Adding each and evey scribble as an instance
                    pts.add(Drawingplace(
                        point: detail.localPosition,
                        drawingarea: Paint()
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = strokeSize
                          ..color = clr ?? Colors.black
                          ..isAntiAlias = true));
                  });
                },
                onPanStart: (detail) {
                  setState(() {
                    //Adding each and evey scribble as an instance
                    pts.add(Drawingplace(
                        point: detail.localPosition,
                        drawingarea: Paint()
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = strokeSize
                          ..color = clr ?? Colors.black
                          ..isAntiAlias = true));
                  });
                },
                onPanEnd: (detail) {
                  setState(() {
                    //To notify the drawline that the scribble is ended
                    pts.add(null);
                  });
                },
                child: Stack(
                  children: <Widget>[
                    // Main Drawing area
                    Positioned(
                      width: width,
                      height: height,
                      child: CustomPaint(
                        painter: DrawPad(points: pts),
                      ),
                    ),
                    Positioned(
                      top: height * 0.72,
                      right: 80,
                      child: RotatedBox(
                        quarterTurns: 4,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slider(
                              activeColor: sliderClr,
                              value: strokeSize,
                              min: 2.0,
                              max: 10.0,
                              onChanged: (double x) {
                                setState(() {
                                  strokeSize = x;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    BtnFunction(
                      btnht: height * 0.69,
                      controller: controller,
                      topdist: 200,
                      icons: Icon(Icons.delete),
                      btnclr: Colors.pinkAccent,
                      onclick: () {
                        pts.clear();
//                        print("All clear");
                      },
                    ),
                    BtnFunction(
                      btnht: height * 0.69,
                      controller: controller,
                      topdist: 150,
                      icons: Icon(Icons.clear),
                      btnclr: Colors.lightGreenAccent,
                      onclick: () {
                        setState(() {
                          clr = Colors.white;
                          Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text(
                              "Your in Eraser mode [Change Color] in Color Palette.",
                              style: TextStyle(fontSize: 10),
                            ),
                          ));
                        });
                      },
                    ),
                    BtnFunction(
                      btnht: height * 0.69,
                      controller: controller,
                      topdist: 100,
                      icons: Icon(Icons.undo),
                      btnclr: Colors.purpleAccent,
                      onclick: () {
                        // pts.length ~/5 also works its known as integer division
                        pts.removeRange((pts.length * 0.8).floor(), pts.length);
                        if (pts.length <= 5) pts.clear();
                        pts.add(null);
                      },
                    ),
                    BtnFunction(
                      btnht: height * 0.69,
                      controller: controller,
                      topdist: 50,
                      icons: Icon(Icons.color_lens),
                      btnclr: Colors.indigoAccent,
                      onclick: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Clrbtmsht(
                                  onclicking: () {
                                    Navigator.pop(context);
                                    selectColor();
                                  },
                                  onclick: () {
                                    Navigator.pop(context);
                                    selectColor2();
                                  },
                                ));
//                        setState(() {
//                        clr = Colors.black;
//                        });
//                        print("Colors");
                      },
                    ),
                    Positioned(
                      top: height * 0.69,
                      right: 15,
                      child: RotationTransition(
                        turns: controller,
                        child: MyroundButtons(
                          onclick: () {
//                            print(height * 0.69);
                            if (controller.isCompleted) {
                              controller.reverse(from: 1);
                            } else {
                              controller.forward();
                            }
                          },
                          width: 60,
                          height: 60,
                          ico: Icon(Icons.settings),
                          btnclr: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
