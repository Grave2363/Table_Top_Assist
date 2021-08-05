import 'dart:math';
import 'package:rpgcompanion/shared/const.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Decode extends StatefulWidget {
  const Decode({Key key}) : super(key: key);

  @override
  _DecodeState createState() => _DecodeState();
}

class _DecodeState extends State<Decode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('RPG Companion'),
      ),
    );
  }
}
