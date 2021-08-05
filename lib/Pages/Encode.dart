import 'dart:math';
import 'package:rpgcompanion/shared/const.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Encode extends StatefulWidget {
  const Encode({Key key}) : super(key: key);

  @override
  _EncodeState createState() => _EncodeState();
}

class _EncodeState extends State<Encode> {
  int cypher_val = 0;
  String cypher = '';
  String res = '';
  int ch = 0;
  int offset ;
  _encode()
  {
    for(int i = 0; i < cypher.length; i++)
    {
      ch = cypher.codeUnitAt(i);
      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0))
      {
        offset = 97;
      }
      else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0))
      {
        offset = 65;
      }
      else if (ch >= ' '.codeUnitAt(0))
      {
        res += " ";
        continue;
      }
      res += String.fromCharCode(((ch + cypher_val - offset) % 26) + offset);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('RPG Companion'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(onChanged: (val) {setState(() => cypher_val = int.parse(val));}, decoration: textInputDecor.copyWith(hintText: 'Number to offset the cypher')),
            TextField(onChanged: (val) {setState(() => cypher = val);}, decoration: textInputDecor.copyWith(hintText: 'Message to encode')),
            RaisedButton(color: Colors.red, child: Text('Roll Dice'), onPressed:(){
              setState(() {
                _encode();
              });},
            ),
            TextField(decoration: staticTextDecor.copyWith(hintText: '$res',hintStyle: TextStyle(color: Colors.black),), enabled: false,),
          ],
        ),
      ),
    );
  }
}
