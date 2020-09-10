import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class listOfChats extends StatefulWidget {
  @override
  _listOfChatsState createState() => _listOfChatsState();
}

// ignore: camel_case_types
class _listOfChatsState extends State<listOfChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('RPG Companion'),
      ),);
  }
}
