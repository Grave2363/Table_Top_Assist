import 'dart:io';
import 'dart:math';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpgcompanion/Authenticate/regester.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/shared/loading.dart';
import 'MapSave.dart';
class LoadMap extends StatefulWidget {
  @override
  _LoadMap createState() => _LoadMap();
}
class _LoadMap extends State<LoadMap> {
  var name = "";
  bool loadNext = true;
  var names = new List(20);
  String error = "";
  File imageFile ;
  String imgFromPrefs;
  bool processing = false;


  void dispose(){
    super.dispose();
  }
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Search for A Map'),
        actions: <Widget>[
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(onChanged: (val) {setState(() => name = val);},validator: (val) => val.isEmpty ? 'Enter the Name of A Map': null,decoration: textInputDecor.copyWith(hintText: 'name'),),
              FlatButton( color: Colors.red, child: Text('Find Map'),  onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapSave(name: name, load: loadNext,)
                ));
              },
              ),
              FlatButton( color: Colors.red, child: Text('Get Random Map'),  onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapSave(load: loadNext,)
                ));
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
