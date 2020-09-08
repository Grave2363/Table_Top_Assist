import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/servicces/databade.dart';

class ChatSearch extends StatefulWidget {
  @override
  _ChatSearchState createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  TextEditingController editCon = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Chat Search'),
        actions: <Widget>[
        ],
      ),body: Container(
        color: Colors.blueGrey,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical:  14),
        child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: editCon,
                decoration: InputDecoration(
                  hintText: "Search user",
                  hintStyle: TextStyle(
                    color: Colors.white
                  ),
                  border: InputBorder.none,
                ),
              )),
              GestureDetector(
                onTap: databaseService().getUserByName(editCon.text),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey,
                             Colors.blueGrey,]
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.all(12),
                  child: Image.asset("assets/search.jpg")
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
