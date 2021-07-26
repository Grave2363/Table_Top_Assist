import 'dart:io';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/Pages/CharRetriever.dart';
import 'package:rpgcompanion/model/CharSheet.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:rpgcompanion/widgets/calc_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class Calc extends StatefulWidget {
  const Calc({Key key}) : super(key: key);

  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('RPG Companion'),
    ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calc_btn(text: 'AC', textSize: 24, fillColor: 0xFF8ac4d0),
                calc_btn(text: 'C', textSize: 24, fillColor: 0xFF8ac4d0),
                calc_btn(text: 'DEL', textSize: 20, fillColor: 0xFF8ac4d0),
                calc_btn(text: '/', textSize: 24, fillColor: 0xFF8ac4d0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calc_btn(text: '9', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '8', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '7', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: 'X', textSize: 24, fillColor: 0xFF8ac4d0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calc_btn(text: '6', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '5', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '4', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '-', textSize: 40, fillColor: 0xFF8ac4d0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calc_btn(text: '3', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '2', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '1', textSize: 24, fillColor: 0xFF000000),
                calc_btn(text: '+', textSize: 24, fillColor: 0xFF8ac4d0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calc_btn(text: '+/-', textSize: 22, fillColor: 0xFF8ac4d0),
                calc_btn(text: '0', textSize: 24, fillColor: 0xFF8ac4d0),
                calc_btn(text: '00', textSize: 24, fillColor: 0xFF8ac4d0),
                calc_btn(text: '=', textSize: 24, fillColor: 0xFF8ac4d0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
