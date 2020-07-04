import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

List<CustomCard> tags = [];

class _NotesState extends State<Notes> {
  String crdTitle = '', crdContent = '';
  // For Local storage
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    initiatesharedPref();
    super.initState();
  }

  void initiatesharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadfrmsharedPref();
  }

  void loadfrmsharedPref() async {
    //'tags' is just the key name
    List<String> from_db = await sharedPreferences.getStringList('tags');
    if (from_db != null) {
      tags =
          from_db.map((item) => CustomCard.fromMap(json.decode(item))).toList();
      setState(() {});
    }
  }

  void savetosharedPref() {
    List<String> to_db = tags.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('tags', to_db);
    //    print(to_db);
/*
*   [{"title":"naresh","content":"Naruto naresh","date":"2020-07-03 18:16"}, {"title":"hello","content":"fhjkkkvhxhcjcjcjjcncjc","date":"2020-07-03 18:16"}]
*
* */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: (context),
              builder: (context) => Container(
                    height: 550,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Set The Title",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            onChanged: (char) {
                              setState(() {
                                crdTitle = char;
                              });
                            },
                            autofocus: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Add Your Notes",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration:
                                InputDecoration(hintText: "Max of 120 chars"),
                            onChanged: (char) {
                              setState(() {
                                crdContent = char;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            child: Text("Add"),
                            onPressed: () {
                              setState(() {
                                if (crdTitle != '' && crdContent != '') {
                                  tags.add(CustomCard(
                                    titl: crdTitle,
                                    cont: crdContent,
                                    dat: DateTime.now()
                                        .toString()
                                        .substring(0, 16),
                                  ));
                                  crdContent = '';
                                  crdTitle = '';
                                  savetosharedPref();
                                }
                              });
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ));
        },
      ),
      body: Container(
        child: tags.length != 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    child: CustomCard(
                      titl: tags[index].titl,
                      cont: tags[index].cont,
                      dat: tags[index].dat,
                    ),
                    onDismissed: (dis) {
                      setState(() {
//                        print(dis);
                        tags.removeAt(index);
                        savetosharedPref();
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Note was Deleted..!"),
                        ));
                      });
                    },
                  );
                },
                itemCount: tags.length)
            : Center(child: Text("Save Your Short Notes Here :)")),
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  String titl, cont, dat;
  CustomCard({this.titl, this.cont, this.dat});

  //used to retrive data[important]
  CustomCard.fromMap(Map map)
      : this.titl = map['title'],
        this.cont = map['content'],
        this.dat = map['date'];
  //used to convert to map[important]
  Map toMap() {
    return {
      'title': this.titl,
      'content': this.cont,
      'date': this.dat,
    };
  }

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.purpleAccent,
            gradient: LinearGradient(colors: [
              Color(0xff56ab2f),
              Color(0xffa8e063),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  color: Colors.redAccent,
                  blurRadius: 8.0,
                  offset: Offset(0, 6))
            ],
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.titl}".toUpperCase(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Created on ${widget.dat}",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "${widget.cont}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            )),
      ),
    );
  }
}
