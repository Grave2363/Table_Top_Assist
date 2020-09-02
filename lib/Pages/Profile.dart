import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class profile extends StatefulWidget {
  final String name;
  profile({Key key, this.name,}): super(key:key);
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  File imageFile ;
  String imgFromPrefs;
  bool processing = false;
  String recName = '';
  String imgString = "";
  String nameVal = "";
  bool newImg = false;
  Widget getImageWidget() {
    if (imageFile != null) {
      return Image.file(
        imageFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
    else if (imgFromPrefs != null){
      return Image.file(File(imgFromPrefs) ,
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
  _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
  }
  _save() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
  }
  void dispose(){
    super.dispose();
    _save();
  }
  void initState()
  {
    super.initState();
    _read();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
