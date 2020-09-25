import 'dart:io';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/Pages/CharRetriever.dart';
import 'package:rpgcompanion/model/CharSheet.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: camel_case_types
class makeCharacter extends StatefulWidget {
  final String name;
  final bool load ;
  final bool rand;
  makeCharacter({Key key, this.name, this.load, this.rand}): super(key:key);
  @override
  _makeCharacterState createState() => _makeCharacterState();
}

// ignore: camel_case_types
class _makeCharacterState extends State<makeCharacter> {
  final AuthSer _auth = AuthSer();
  int i = 0;
  // ignore: non_constant_identifier_names
  var Levels = ['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];
  var standardStats = ['0','8','10','12','13','14','15'];
  String userName = '';
  File imageFile ;
  String imgFromPrefs;
  bool processing = false;
  String email = "";
  String recName = '';
  String imgString = "";
  String nameVal = "";
  String classes = '';
  // ignore: non_constant_identifier_names
  String Int = '0';
  String standInt = '0';
  // ignore: non_constant_identifier_names
  String Str = '0';
  String standStr = '0';
  // ignore: non_constant_identifier_names
  String Dex = '0';
  String standDex = '0';
  // ignore: non_constant_identifier_names
  String Const = '0';
  String standConst = '0';
  // ignore: non_constant_identifier_names
  String Wis = '0';
  String standWis = '0';
  // ignore: non_constant_identifier_names
  String Char = '0';
  String standChar = '0';
  String level = '0';
  String standLevel = '0';
  String skills = '';
  String magic = '';
  bool next = false;
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
  _save() async{
    final pref = await SharedPreferences.getInstance();
    var nameList = pref.getStringList('Names');
    if (nameList == null)
    {
      nameList = List<String>();
    }
   // final nameKey = '$nameVal';
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
    if (nameVal.length > 0 && !nameList.contains(nameVal))
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
      if (standInt != standardStats[0]){await pref.setString(intKey, standInt);}
      else if (Int.length > 0){ await pref.setString(intKey, Int);}
      if (standStr != standardStats[0]){await pref.setString(intKey, standStr);}
      else  if (Str.length > 0){ await pref.setString(strKey, Str);}
      if (standDex != standardStats[0]){await pref.setString(intKey, standDex);}
      else if (Dex.length > 0){ await pref.setString(dexKey, Dex);}
      if (standConst != standardStats[0]){await pref.setString(intKey, standConst);}
      else if (Const.length > 0){ await pref.setString(constKey, Const);}
      if (standWis != standardStats[0]){await pref.setString(intKey, standWis);}
      else if (Wis.length > 0){ await pref.setString(wisKey, Wis);}
      if (standChar != standardStats[0]){await pref.setString(intKey, standChar);}
      else if (Char.length > 0){ await pref.setString(charKey, Char);}
      if (level.length > 0){ await pref.setString(levelKey, level); print('Saved Level');}
      print('Saving Completed');
  }
  _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = pref.getString("Email");
    userName = pref.getString("User");
    final nList = pref.getStringList("Names") ;
    final _random = new Random();
    if (nList == null)
    {

    }
    else if (rand == true)
    {
      int r = nList.length;
       i = _random.nextInt(r - 1);
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
      rand = false;
    }
    else if (next == true)
    {
      int r = nList.length;
      i += 1;
      nameVal = nList[i];
      if (i >= r){ i = 0;}
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
      next = false;
      setState(() {});
    }
    else if (nList.contains(nameVal) && searching == true)
    {
      _nameController.text = nameVal;
      _levelController.text = pref.getString('$nameVal level');
      _magicController.text = pref.getString('$nameVal magic');
      _skillController.text = pref.getString(('$nameVal magic'));
      _classController.text = pref.getString('$nameVal class');
      _intController.text = pref.getString('$nameVal int');
      _strController.text = pref.getString('$nameVal str');
      _dexController.text = pref.getString('$nameVal dex');
      _constController.text = pref.getString('$nameVal const');
      _wisController.text = pref.getString('$nameVal wis');
      _charController.text = pref.getString('$nameVal char');
      imgFromPrefs = pref.getString('$nameVal img');
      searching = false;
      setState(() {});
    }
  }
  void deleteChar() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final nList = pref.getStringList("Names");
    List<String> cpyList = List<String>(nList.length);
    pref.remove('$nameVal level');
    pref.remove('$nameVal magic');
    pref.remove(('$nameVal magic'));
    pref.remove('$nameVal class');
    pref.remove('$nameVal int');
    pref.remove('$nameVal str');
    pref.remove('$nameVal dex');
    pref.remove('$nameVal const');
    pref.remove('$nameVal wis');
    pref.remove('$nameVal char');
    pref.remove('$nameVal img');
    for (int i = 0; i < nList.length; i++)
    {
      if (nList[i] != nameVal)
      {
        cpyList.add(nList[i]);
      }
    }
    await pref.setStringList("Names", cpyList);
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
      return Image.file(File(imgFromPrefs.toString()) ,
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
    return    StreamProvider<List<CharSheet>>.value(
    value: databaseService().characters,
    child: Scaffold(
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
              CharacterRetreval(),
              TextField(onChanged: (val) {setState(() => nameVal = val);}, controller: _nameController, decoration: textInputDecor.copyWith(hintText: 'Name')),
              FlatButton(
                color: Colors.red, child: Text('Get Image From Gallery'),
                onPressed: (){
                  getImage(ImageSource.gallery);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 110,
                    child:  FlatButton( color: Colors.red, child: Text('Get Character'),   onPressed: ()  async{
                      setState(() {
                        searching = true;
                        _read();
                      });
                    },),
                  ),
                  Container(
                    width: 120,
                    child:
                    FlatButton( color: Colors.red, child: Text('Random Character'),   onPressed: ()  async{
                    setState(() {
                      rand = true;
                      _read();
                    });
                  },),),
                  Container(
                    width: 120,
                    child:
                    FlatButton( color: Colors.red, child: Text('Next Character'), onPressed: () async {
                    next = true;
                    _read();
                  },),),
                ],
              ),
              getImageWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child:
                    TextField(decoration: staticTextDecor.copyWith(hintText: 'Character Level : ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: DropdownButton<String>(
                      items: Levels.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                      onChanged:(String val){
                        setState(() {
                          this.level = val;
                          this.standLevel = val;
                        });
                        print(standLevel);
                      },
                      value: standLevel,
                    ),),
                ],),
              TextField(onChanged: (val) {setState(() => classes = val);}, controller: _classController, decoration: textInputDecor.copyWith(hintText: 'Classes'), keyboardType: TextInputType.multiline, maxLines: null,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child:
                    TextField(decoration: staticTextDecor.copyWith(hintText: 'Strength (Standard): ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: DropdownButton<String>(
                      items: standardStats.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                      onChanged:(String val){
                        setState(() {
                          this.standStr = val;
                        });
                        print(standStr);
                      },
                      value: standStr,
                    ),),
                ],),
              TextField(onChanged: (val) {setState(() => Str = val);}, controller: _strController, decoration: textInputDecor.copyWith(hintText: 'Rolled Strength ')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child:
                    TextField(decoration: staticTextDecor.copyWith(hintText: 'Dexterity (Standard): ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: DropdownButton<String>(
                      items: standardStats.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                      onChanged:(String val){
                        setState(() {
                          this.standDex = val;
                        });
                        print(standDex);
                      },
                      value: standDex,
                    ),),
                ],),
              TextField(onChanged: (val) {setState(() => Dex = val);}, controller: _dexController, decoration: textInputDecor.copyWith(hintText: 'Rolled Dexterity')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child:
                    TextField(decoration: staticTextDecor.copyWith(hintText: 'Constitution (Standard): ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: DropdownButton<String>(
                      items: standardStats.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                      onChanged:(String val){
                        setState(() {
                          this.standConst = val;
                        });
                        print(standConst);
                      },
                      value: standConst,
                    ),),
                ],),
              TextField(onChanged: (val) {setState(() => Const = val);}, controller: _constController, decoration: textInputDecor.copyWith(hintText: 'Rolled Constitution')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child:
                    TextField(decoration: staticTextDecor.copyWith(hintText: 'Intelligence (Standard): ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: DropdownButton<String>(
                      items: standardStats.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                      onChanged:(String val){
                        setState(() {
                          this.standInt = val;
                        });
                        print(standInt);
                      },
                      value: standInt,
                    ),),
                ],),
              TextField(onChanged: (val) {setState(() => Int = val);}, controller: _intController, decoration: textInputDecor.copyWith(hintText: 'Rolled Intelligence')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child:
                    TextField(decoration: staticTextDecor.copyWith(hintText: 'Wisdom (Standard): ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: DropdownButton<String>(
                      items: standardStats.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                      onChanged:(String val){
                        setState(() {
                          this.standWis = val;
                        });
                        print(standWis);
                      },
                      value: standWis,
                    ),),
                ],),
              TextField(onChanged: (val) {setState(() => Wis = val);}, controller: _wisController, decoration: textInputDecor.copyWith(hintText: 'Rolled Wisdom')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child:
                    TextField(decoration: staticTextDecor.copyWith(hintText: 'Charisma (Standard): ',hintStyle: TextStyle(color: Colors.black),),enabled: false,),),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: DropdownButton<String>(
                      items: standardStats.map((String dropDownStringItem){return DropdownMenuItem<String>(value: dropDownStringItem,child: Text(dropDownStringItem),);}).toList(),
                      onChanged:(String val){
                        setState(() {
                          this.standChar = val;
                        });
                        print(standChar);
                      },
                      value: standChar,
                    ),),
                ],),
              TextField(onChanged: (val) {setState(() => Char = val);}, controller: _charController, decoration: textInputDecor.copyWith(hintText: 'Rolled Charisma')),
              TextField(onChanged: (val) {setState(() => skills = val);}, controller: _skillController, decoration: textInputDecor.copyWith(hintText: 'Skills'), keyboardType: TextInputType.multiline, maxLines: null,),
              TextField(onChanged: (val) {setState(() => magic = val);}, controller: _magicController, decoration: textInputDecor.copyWith(hintText: 'Magic'), keyboardType: TextInputType.multiline, maxLines: null,),
              SizedBox(height: 20.0,),
              FlatButton( color: Colors.red, child: Text('Save'), onPressed: () async {
                _save();
                print(widget.name);
              },),
              FlatButton( color: Colors.red, child: Text('Delete this Character'),   onPressed: ()  async{
                deleteChar();
               },),
              FlatButton(
                color: Colors.red, child: Text('Upload Sheet'),
                onPressed: () async{
                  if (_auth.IsUserAnon() == false)
                  {
                    databaseService().setCollect(email);
                    databaseService().uploadData( _levelController.text,_classController.text,_strController.text, _intController.text, _constController.text, _wisController.text, _dexController.text,
                        _charController.text, _nameController.text, _skillController.text, _magicController.text);
                    i++;
                  }
                },
              ),
            ],
          ),
        ),),
    );
  }
}
