import 'dart:math';
import 'package:rpgcompanion/shared/const.dart';
import 'package:flutter/material.dart';
import 'dart:core';

// ignore: camel_case_types
class diceRoll extends StatefulWidget {
  @override
  _diceRollState createState() => _diceRollState();
}

// ignore: camel_case_types
class _diceRollState extends State<diceRoll> {
  final _random = new Random();
  var dice = ['4','6','8','10','12','20'];
  int die = 20;
  int num = 1; // number of dice to roll
  int advantage = 0;
  int disadvantage = 0;
  int res = 0;
  // ignore: non_constant_identifier_names
  String Die = '20';
  int calcResult ()
  {
    int fin = 0;
    int max = die + 1;
    for (int i = 0; i < num; i++) {
      fin +=1 + _random.nextInt(max - 1);
    }
    fin = fin - disadvantage;
    fin = fin + advantage;
    return fin;
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
          crossAxisAlignment:  CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 220,
                  child:
                  TextField(decoration: staticTextDecor.copyWith(hintText: 'Die Size : ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                Container(
                  width: 150,
                  color: Colors.white,
                  child: DropdownButton<String>(
                 items: dice.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                onChanged:(String val){
                  setState(() {
                    this.Die = val;
                    this.die = int.parse(val);
                  });
                  print(Die);
                },
                value: Die,
              ),),
            ],),
            TextField(onChanged: (val) {setState(() => num = int.parse(val));}, decoration: textInputDecor.copyWith(hintText: 'Number of dice to roll')),
            TextField(onChanged: (val) {setState(() => advantage =int.parse( val));}, decoration: textInputDecor.copyWith(hintText: 'Advantage')),
            TextField(onChanged: (val) {setState(() => disadvantage =int.parse(val));}, decoration: textInputDecor.copyWith(hintText: 'Disadvantage')),
            RaisedButton(color: Colors.red, child: Text('Roll Dice'), onPressed:(){
              setState(() {
               res = calcResult();
               if (res < 0){
                 res = 0;
               }
              });
            } ,

            ),
            TextField(decoration: staticTextDecor.copyWith(hintText: '$res',hintStyle: TextStyle(color: Colors.black),), enabled: false,),
          ],
        ),
      ),
    );
  }
}
