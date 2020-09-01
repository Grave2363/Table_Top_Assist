import 'dart:io';
import 'dart:math';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class makeCharacter extends StatefulWidget {
  final String name;
  final bool load ;
  final bool rand;
  makeCharacter({Key key, this.name, this.load, this.rand}): super(key:key);
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
  bool rand = false;
  bool searching = false;
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
    var nameList = pref.getStringList('Names');
    if (nameList == null)
    {
      nameList = List<String>();
    }
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
      nameList.add(nameVal);
      await pref.setStringList("Names", nameList);
      print('Saved name $nameVal');
    }
    if (newImg == true)
    {
      imgString = imageFile.path;
      await pref.setString(ingKey, imgString);
      print('$imgString');
      print('$imageFile');
      print('Saved new Img');
    }
      if (skills.length > 0){ await pref.setString(skillKey, skills); print('Saved Sk');}
      if (magic.length > 0){ await pref.setString(magicKey, magic); print('Saved Mag');}
      if (classes.length > 0){ await pref.setString(classKey, classes); print('Saved class');}
      if (Int.length > 0){ await pref.setString(intKey, Int);}
      if (Str.length > 0){ await pref.setString(strKey, Str);}
      if (Dex.length > 0){ await pref.setString(dexKey, Dex);}
      if (Const.length > 0){ await pref.setString(constKey, Const);}
      if (Wis.length > 0){ await pref.setString(wisKey, Wis);}
      if (Char.length > 0){ await pref.setString(charKey, Char);}
      if (level.length > 0){ await pref.setString(levelKey, level); print('Saved Level');}
      print('Saving Completed');
  }
  _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final nList = pref.getStringList("Names") ;
    final _random = new Random();
    if (rand == true)
    {
      int r = nList.length;
      int i = _random.nextInt(r - 1);
      nameVal = nList[i];
      _nameController.text = nameVal;
      _levelController.text = pref.getString('$nameVal level');
      _magicController.text = pref.getString('$nameVal magic');
      _skillController.text = pref.getString('$nameVal skill');
      _classController.text = pref.getString('$nameVal class');
      _intController.text = pref.getString('$nameVal int');
      _strController.text = pref.getString('$nameVal str');
      _dexController.text = pref.getString('$nameVal dex');
      _constController.text = pref.getString('$nameVal const');
      _wisController.text = pref.getString('$nameVal wis');
      _charController.text = pref.getString('$nameVal char');
      imgFromPrefs = pref.getString('$nameVal img');
    }
    else if (nList.contains(nameVal) && searching == true)
    {
      _nameController.text = nameVal;
      _levelController.text = pref.getString('$nameVal level');
      _magicController.text = pref.getString('$nameVal magic');
      _skillController.text = pref.getString('$nameVal skill');
      _classController.text = pref.getString('$nameVal class');
      _intController.text = pref.getString('$nameVal int');
      _strController.text = pref.getString('$nameVal str');
      _dexController.text = pref.getString('$nameVal dex');
      _constController.text = pref.getString('$nameVal const');
      _wisController.text = pref.getString('$nameVal wis');
      _charController.text = pref.getString('$nameVal char');
      imgFromPrefs = pref.getString('$nameVal img');
      searching = false;
    }
  }
  void dispose(){
    super.dispose();
    _save();
  }
  void initState()
  {
    super.initState();
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
            FlatButton( color: Colors.red, child: Text('Get Character'),   onPressed: ()  async{
              setState(() {
                searching = true;
                _read();
              });
            },),
            FlatButton( color: Colors.red, child: Text('Get Random Character'),   onPressed: ()  async{
              setState(() {
                rand = true;
                _read();
              });
            },),
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
            FlatButton( color: Colors.red, child: Text('Clear Saved Characters'),   onPressed: ()  async{
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
      },)
          ],
        ),
      ),
    );
  }
}
