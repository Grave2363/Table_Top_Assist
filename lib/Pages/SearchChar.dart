import 'package:flutter/material.dart';
import 'package:rpgcompanion/Authenticate/regester.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:rpgcompanion/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'charCreation.dart';
class CharSearch extends StatefulWidget {
  @override
  _CharSearch createState() => _CharSearch();
}

class _CharSearch extends State<CharSearch> {
var name = "";
bool loadNext = true;
var names = new List(20);
String error = "";
_read() async
{
  SharedPreferences pref = await SharedPreferences.getInstance();
  names = pref.getStringList('Names');
}
void dispose(){
  super.dispose();
}
void initState()
{
  super.initState();
    _read();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Search for Character'),
        actions: <Widget>[
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(onChanged: (val) {setState(() => name = val);},validator: (val) => val.isEmpty ? 'Enter a name': null,decoration: textInputDecor.copyWith(hintText: 'name'),),
              FlatButton( color: Colors.red, child: Text('Find Character'),  onPressed: ()  {
                if (names.contains(name))
                {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => makeCharacter(name: name, load: loadNext,)
                ));
                }
                else {
                  setState(() {
                    error = 'Character has not been created.';
                    });
                }
              },
              ),
              SizedBox(height: 15.0,),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 12.0),),
            ],
          ),
        ),
      ),
    );
  }
}
