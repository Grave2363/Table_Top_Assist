import 'package:flutter/material.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'noteMain.dart';
class editNote extends StatefulWidget {
  final String recName;
  editNote({Key key, this.recName}): super(key:key);
  @override
  _editNoteState createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  List<String> names = [];
  int i = 0;
  String selName = '';
  String initName = '';
  String noteContents = '';
  final _titleController = TextEditingController();
  final _contentsController = TextEditingController();
  _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
      names =  pref.getStringList('index_of_keys');
      if (i < names.length){selName = names[i];}
      noteContents = pref.getString('$selName');
      _titleController.text = selName;
      _contentsController.text = noteContents;
  }
  _save() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (names.contains(selName)){}
    else if (selName.length > 2){ names.add(selName);  print('new name : $selName');}
    pref.setStringList('index_of_keys', names);
    pref.setString(selName, noteContents);
    print(names);
  }
  _clear () async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < names.length; i++){ await pref.remove(names[i]);}
    await pref.remove('index_of_keys');
    names.clear();
  }
  @override
  void dispose(){
    super.dispose();
    _save();
  }
  @override
  void initState()
  {
    super.initState();
    _read();
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
      body: Column(
        children: <Widget>[
          TextField(onChanged: (val) {setState(() => selName = val);},controller: _titleController ,decoration: textInputDecor.copyWith(hintText: 'Title of Note')),
          TextField(onChanged: (val) {setState(() => noteContents = val);},controller: _contentsController ,decoration: textInputDecor.copyWith(hintText: 'Contents of Note'), keyboardType: TextInputType.multiline, maxLines: null,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                color: Colors.red,
                child: Text('Clear Notes'),
                onPressed: ()  {
                  _clear();
                },
              ),
              FlatButton(
                color: Colors.red,
                child: Text('Next Note'),
                onPressed: ()  {
                  setState(() {
                    i = i +1;
                    _read();
                  });
                },
              ),
              FlatButton(
                color: Colors.red,
                child: Text('New Note'),
                onPressed: ()  {
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
