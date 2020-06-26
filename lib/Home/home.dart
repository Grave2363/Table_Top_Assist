import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/Pages/Dice.dart';
import 'package:rpgcompanion/Pages/charCreation.dart';
import 'package:rpgcompanion/Pages/editNote.dart';
import 'package:rpgcompanion/Pages/noteMain.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class home extends StatelessWidget {
  final AuthSer _auth = AuthSer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('RPG Companion'),
        actions: <Widget>[
          FlatButton.icon(onPressed: ()async{
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('Log Out'))
        ],
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            color: Colors.red,
            child: Text('Character Creation'),
            onPressed: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => makeCharacter()
              ));
            },
          ),
          FlatButton(
            color: Colors.red,
            child: Text('  View Characters  '),
            onPressed: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => makeCharacter(load: true,)
              ));
            },
          ),
          FlatButton(
            color: Colors.red,
            child: Text('         Roll Dice         '),
            onPressed: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => diceRoll()
              ));
            },
          ),
          FlatButton(
            color: Colors.red,
            child: Text('      Game Notes      '),
            onPressed: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => editNote()
              ));
            },
          ),
        ],
      ),),
    );
  }
}
