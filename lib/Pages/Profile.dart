import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class profile extends StatefulWidget {
  final String name;
  profile({Key key, this.name,}): super(key:key);
  @override
  _profileState createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {
  // ignore: non_constant_identifier_names
  String User = '';
  String email = '';
  String bio = '';
  final _bioController = TextEditingController();
  final _userController = TextEditingController();
  File imageFile ;
  String imgFromPrefs;
  bool processing = false;
  String recName = '';
  String imgString = "";
  String nameVal = "";
  bool newImg = false;
  Widget getImageWidget() {
    if (imageFile != null) {
      imgFromPrefs = imageFile.path;
      return Image.file(
        imageFile,
        width: 250,
        height: 250,
        fit: BoxFit.contain,);
    }
    else if (imgFromPrefs != null){
      return Image.file(File(imgFromPrefs.toString()) ,
        width: 250,
        height: 250,
        fit: BoxFit.contain,);
    }
    else {
      return Image.asset(
        "assets/placeholder.jpg",
        width: 250,
        height: 252,
        fit: BoxFit.contain,
      );
    }
  }
  getImage(ImageSource source) async {
    this.setState((){
      processing = true;
    });
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);
    if(image != null){
      this.setState((){
        imageFile = image;
        processing = false;
      });
    } else {
      this.setState((){
        processing = false;
      });
    }
  }
  void initState()
  {
    _read();
    super.initState();

  }
  void dispose(){
    _save();
    super.dispose();

  }
  _read() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userController.text = pref.getString('User');
    imgFromPrefs = pref.getString('User Pic');
    bio = pref.getString('User Bio');
    email = pref.getString('Email');
    setState(() {});
  }
  _save() async
  {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('User', _userController.text);
    await pref.setString('User Pic', imgFromPrefs);
    await pref.setString('User Bio', bio);
    databaseService().setCollect(email);
    databaseService().uploadUserName( _userController.text, email);
    print("Completed update");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('RPG Companion'),
    ),
     body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextField(onChanged: (val) {setState(() => User = val);},controller: _userController ,decoration: textInputDecor.copyWith(hintText: 'Profile Name', enabled: false),),
          FlatButton(
            color: Colors.red, child: Text('Get Image From Gallery'),
            onPressed: (){
              getImage(ImageSource.gallery);
              newImg = true;
            },
          ),
          getImageWidget(),
          TextField(onChanged: (val) {setState(() => bio = val);}, controller: _bioController, decoration: textInputDecor.copyWith(hintText: 'Enter Whatever'), keyboardType: TextInputType.multiline, maxLines: null,),
          FlatButton(
            color: Colors.red, child: Text('Save changes'),
            onPressed: (){
              _save();
            },
          ),
        ],
      ),
    ),
    );
  }
}
