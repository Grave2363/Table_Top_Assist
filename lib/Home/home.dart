import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/Home/userGet.dart';
import 'package:rpgcompanion/Pages/CharRetriever.dart';
import 'package:rpgcompanion/Pages/ChatList.dart';
import 'package:rpgcompanion/Pages/Dice.dart';
import 'package:rpgcompanion/Pages/MapSave.dart';
import 'package:rpgcompanion/Pages/Profile.dart';
import 'package:rpgcompanion/Pages/charCreation.dart';
import 'package:rpgcompanion/Pages/editNote.dart';
import 'package:rpgcompanion/model/CharSheet.dart';
import 'package:rpgcompanion/model/UserInfo.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthSer _auth = AuthSer();
  String email = '';
  String User = '';
  File imageFile ;
  String imgFromPrefs;
  final _userController = TextEditingController();
  void  setImg(String img)
  {
    this.imgFromPrefs = img;
  }
  void initState()
  {
    super.initState();
    _read();
  }
  _read() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    User = pref.getString('User');
    email = pref.getString("Email");
    print("Email "+email);
    print("Username "+User);
    setState(() {});
  }
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
        body: SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              color: Colors.red,
              child: Text('Profile'),
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => profile()
                ),
                ).then((_){_read();setState(() {});
                });
              },
            ),
            FlatButton(
              color: Colors.red,
              child: Text('Character Sheets'),
              onPressed: ()  {
                databaseService().setCollect(email);
                print(email);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => makeCharacter(load: false,name: _userController.text,)
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
            FlatButton(
              color: Colors.red,
              child: Text('  Chat Lists  '),
              onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatSearch()
                ));
              },
            ),
          ],
        ),),
    );
  }
}
