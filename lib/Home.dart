import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scribbly/Screens/Drawpage.dart';
import 'package:scribbly/Screens/NotesComp.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "Scribbly",
            style: TextStyle(fontFamily: 'Yellowtail', fontSize: 30),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.brush),
//                text: "DRAW",
              ),
              Tab(
                icon: Icon(Icons.book),
//                text: "SAVED",
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
//          controller: _tabController,
          children: <Widget>[
            Mypainting(),
            Notes()
//            Center(
//              child: Text("Nothing saved yet!"),
//            )
          ],
        ),
      ),
    );
  }
}
