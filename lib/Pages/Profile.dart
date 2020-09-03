import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/Home/home.dart';
import 'dart:io';
import 'dart:math';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpgcompanion/Home/home.dart';
class profile extends StatefulWidget {
  final String name;
  profile({Key key, this.name,}): super(key:key);
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String User = '';
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
        fit: BoxFit.cover,);
    }
    else if (imgFromPrefs != null){
      return Image.asset(imgFromPrefs.toString() ,
        width: 250,
        height: 250,
        fit: BoxFit.cover,);
    }
    else {
      return Image.asset(
        "assets/placeholder.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
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
    _userController.text = pref.getString('User');
    imgFromPrefs = pref.getString('User Pic');
    setState(() {});
  }
  _save() async
  {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('User', _userController.text);
    await pref.setString('User Pic', imgFromPrefs);
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
          TextField(onChanged: (val) {setState(() => User = val);},controller: _userController ,decoration: textInputDecor.copyWith(hintText: 'Profile Name')),
          FlatButton(
            color: Colors.red, child: Text('Get Image From Gallery'),
            onPressed: (){
              getImage(ImageSource.gallery);
              newImg = true;
            },
          ),
          getImageWidget(),
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
