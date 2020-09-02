import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/Pages/Dice.dart';
import 'package:rpgcompanion/Pages/MapSave.dart';
import 'package:rpgcompanion/Pages/charCreation.dart';
import 'package:rpgcompanion/Pages/editNote.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthSer _auth = AuthSer();
  String User = '';
  final _userController = TextEditingController();
  void initState()
  {
    super.initState();
    _read();
  }
  void dispose(){
    super.dispose();
    _save();
  }
  _read() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    User = pref.getString('User');
  }
  _save() async
  {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('User', User);
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
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(onChanged: (val) {setState(() => User = val);},controller: _userController ,decoration: textInputDecor.copyWith(hintText: 'Desired User Name')),
          FlatButton(
            color: Colors.red,
            child: Text('Character Sheets'),
            onPressed: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => makeCharacter(load: false,name: User,)
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
            child: Text('  Save and  View Images  '),
            onPressed: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapSave()
              ));
            },
          ),
        ],
      ),),
    );
  }
}
