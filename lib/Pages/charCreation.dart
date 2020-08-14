import 'dart:io';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class makeCharacter extends StatefulWidget {
  final String name;
  final bool load ;
  makeCharacter({Key key, this.name, this.load}): super(key:key);
  @override
  _makeCharacterState createState() => _makeCharacterState();
}

class _makeCharacterState extends State<makeCharacter> {
  File imageFile ;
  String imgFromPrefs;
  bool processing = false;
  String recName = '';
  String imgString = "";
  String nameVal = "";
  String classes = '';
  String Int = '';
  String Str = '';
  String Dex = '';
  String Const = '';
  String Wis = '';
  String Char = '';
  String level = '';
  String skills = '';
  String magic = '';
  bool newImg = false;
  final _nameController = TextEditingController();
  final _levelController = TextEditingController();
  final _magicController = TextEditingController();
  final _skillController = TextEditingController();
  final _classController = TextEditingController();
  final _intController = TextEditingController();
  final _strController = TextEditingController();
  final _dexController = TextEditingController();
  final _constController = TextEditingController();
  final _wisController = TextEditingController();
  final _charController = TextEditingController();
  final nameIndex = 'index_of_names';
  _save() async{
    final pref = await SharedPreferences.getInstance();
    final nameList = pref.getStringList('Names');
    final nameKey = '$nameVal';
    final ingKey = '$nameVal img';
    final skillKey = '$nameVal skill';
    final magicKey = '$nameVal magic';
    final classKey = '$nameVal class';
    final intKey = '$nameVal int';
    final strKey = '$nameVal str';
    final dexKey = '$nameVal dex';
    final constKey = '$nameVal const';
    final wisKey = '$nameVal wis';
    final charKey = '$nameVal char';
    final levelKey = '$nameVal level';
    if (nameVal.length > 0)
    {
      nameList.add(nameKey);
      await pref.setStringList('Names', nameList);
    }
    if (newImg == true)
    {
      imgString = imageFile.path;
      await pref.setString(ingKey, imgString);
      print('$imgString');
      print('$imageFile');
    }
      if (skills.length > 1){ await pref.setString(skillKey, skills);}
      if (magic.length > 1){ await pref.setString(magicKey, magic);}
      if (classes.length > 1){ await pref.setString(classKey, classes);}
      if (Int.length > 1){ await pref.setString(intKey, Int);}
      if (Str.length > 1){ await pref.setString(strKey, Str);}
      if (Dex.length > 1){ await pref.setString(dexKey, Dex);}
      if (Const.length > 1){ await pref.setString(constKey, Const);}
      if (Wis.length > 1){ await pref.setString(wisKey, Wis);}
      if (Char.length > 1){ await pref.setString(charKey, Char);}
      if (level.length > 1){ await pref.setString(levelKey, level);}

  }
  _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (recName == null)
    {
      final Nlist = pref.getStringList("Names");
      recName = Nlist[0];
    }
    _levelController.text = pref.getString('$recName level');
     _magicController.text = pref.getString('$recName magic');
     _skillController.text = pref.getString('$recName skill');
     _classController.text = pref.getString('$recName class');
     _intController.text = pref.getString('$recName int');
     _strController.text = pref.getString('$recName str');
     _dexController.text = pref.getString('$recName dex');
     _constController.text = pref.getString('$recName const');
     _wisController.text = pref.getString('$recName wis');
     _charController.text = pref.getString('$recName char');
     imgFromPrefs = pref.getString('$recName img');
  }
  void dispose(){
    super.dispose();
    _save();
  }
  void initState()
  {
    super.initState();
    if (widget.load == false)
    {
      recName = null;
    }
    if (widget.load == true)
    {
      recName = widget.name;
    }
    _read();
  }
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(onChanged: (val) {setState(() => nameVal = val);}, controller: _nameController, decoration: textInputDecor.copyWith(hintText: 'Name')),
            FlatButton(
             color: Colors.red, child: Text('Get Image From Gallery'),
              onPressed: (){
               getImage(ImageSource.gallery);
                },
             ),
            getImageWidget(),
            TextField(onChanged: (val) {setState(() => level = val);}, controller: _levelController, decoration: textInputDecor.copyWith(hintText: 'Level')),
            TextField(onChanged: (val) {setState(() => classes = val);}, controller: _classController, decoration: textInputDecor.copyWith(hintText: 'Classes'), keyboardType: TextInputType.multiline, maxLines: null,),
            TextField(onChanged: (val) {setState(() => Str = val);}, controller: _strController, decoration: textInputDecor.copyWith(hintText: 'Strength')),
            TextField(onChanged: (val) {setState(() => Dex = val);}, controller: _dexController, decoration: textInputDecor.copyWith(hintText: 'Dexterity')),
            TextField(onChanged: (val) {setState(() => Const = val);}, controller: _constController, decoration: textInputDecor.copyWith(hintText: 'Constitution')),
            TextField(onChanged: (val) {setState(() => Int = val);}, controller: _intController, decoration: textInputDecor.copyWith(hintText: 'Intelligence')),
            TextField(onChanged: (val) {setState(() => Wis = val);}, controller: _wisController, decoration: textInputDecor.copyWith(hintText: 'Wisdom')),
            TextField(onChanged: (val) {setState(() => Char = val);}, controller: _charController, decoration: textInputDecor.copyWith(hintText: 'Charisma')),
            TextField(onChanged: (val) {setState(() => skills = val);}, controller: _skillController, decoration: textInputDecor.copyWith(hintText: 'Skills'), keyboardType: TextInputType.multiline, maxLines: null,),
            TextField(onChanged: (val) {setState(() => magic = val);}, controller: _magicController, decoration: textInputDecor.copyWith(hintText: 'Magic'), keyboardType: TextInputType.multiline, maxLines: null,),
            SizedBox(height: 20.0,),
            FlatButton( color: Colors.red, child: Text('Save'), onPressed: () async {
              _save();
            },),
          ],
        ),
      ),
    );
  }
}
