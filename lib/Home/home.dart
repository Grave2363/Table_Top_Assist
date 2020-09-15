import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/Pages/Dice.dart';
import 'package:rpgcompanion/Pages/ListOfChats.dart';
import 'package:rpgcompanion/Pages/Profile.dart';
import 'package:rpgcompanion/Pages/charCreation.dart';
import 'package:rpgcompanion/Pages/editNote.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/servicces/push_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
// ignore: camel_case_types
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  final AuthSer _auth = AuthSer();
  FirebaseMessaging FBM = new FirebaseMessaging();
  String email = '';
  // ignore: non_constant_identifier_names
  String User = '';
  String userToken ='';
  File imageFile ;
  String imgFromPrefs;
  final PushNotificationService push = PushNotificationService();
  void  setImg(String img)
  {
    this.imgFromPrefs = img;
  }
  void initState()
  {
    push.initalise();
    _read();
    databaseService().setCollect(email);
    databaseService().uploadUserName( User, email, userToken);
    super.initState();
  }

  _read() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    User = pref.getString('User');
    email = pref.getString("Email");
    userToken = pref.getString('DeviceToken');
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
                    builder: (context) => makeCharacter()
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
                   if (_auth.IsUserAnon() == false) {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => listOfChats()
                   ));
                  }
              },
            ),
          ],
        ),),
    );
  }
}
