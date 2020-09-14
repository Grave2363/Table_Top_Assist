import 'dart:io';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class MapSave extends StatefulWidget {
  final String name;
  final bool load ;
  final bool rand;
  MapSave({Key key, this.name, this.load, this.rand}): super(key:key);
  @override
  _MapSaveState createState() => _MapSaveState();
}

class _MapSaveState extends State<MapSave> {
  File imageFile ;
  String imgFromPrefs;
  bool processing = false;
  String recName = '';
  String imgString = "";
  String nameVal = "";
  bool newImg = false;
  bool rand = false;
  bool searching = false;
  final _nameController = TextEditingController();
  final nameIndex = 'index_of_names';
  _save() async{
    final pref = await SharedPreferences.getInstance();
    var nameList = pref.getStringList('Names');
    if (nameList == null)
    {
      nameList = List<String>();
    }
    //final nameKey = '$nameVal';
    final ingKey = '$nameVal img';
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
    print('Saving Completed');
  }
  _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final nList = pref.getStringList("Names") ;
   // final _random = new Random();
    if (rand == true)
    {
     // int r = nList.length;
      //int i = _random.nextInt(r - 1);
      _nameController.text = recName;
      imgFromPrefs = pref.getString('$recName img');
    }
    else if (nList.contains(recName) )
    {
      _nameController.text = recName;
      imgFromPrefs = pref.getString('$recName img');
    }
  }
  void dispose(){
    super.dispose();
    _save();
  }
  void initState()
  {
    super.initState();
    if (searching == false)
    {
      recName = '';
    }
    if (searching == true)
    {
      recName = widget.name;
      _read();
    }

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
            SizedBox(height: 20.0,),
            FlatButton( color: Colors.red, child: Text('Save'), onPressed: () async {
              _save();
            },),
            FlatButton( color: Colors.red, child: Text('Search for Img'), onPressed: () async {
              setState(() {
                searching = true;
                _read();
              });
            },),
            FlatButton( color: Colors.red, child: Text('Get Random Img'), onPressed: () async {
              setState(() {
                rand = true;
                _read();
              });
            },),
            FlatButton( color: Colors.red, child: Text('Clear Saved Maps'),   onPressed: ()  async{
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
            },
            )],
        ),
      ),
    );
  }
}
