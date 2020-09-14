import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editNote.dart';
// ignore: camel_case_types
class noteMain extends StatefulWidget {
  @override
  _noteMainState createState() => _noteMainState();
}

// ignore: camel_case_types
class _noteMainState extends State<noteMain> {
  List <String> names = ['New Note'];
  String selName = '';
  int test = 0;
   void addToList(String name) async {
     names.add(name);
   }
  _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    names = pref.getStringList('index_of_keys');
    names.insert(0, 'New Note');
  }
  _save() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
   pref.setStringList('index_of_keys', names);
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
    setState(() {
      test = names.length;
    });
    print('notes $test');
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
      body:Container(
        child:GridView.count(
        padding: EdgeInsets.all(1.0),
        crossAxisCount: 2,
        children: List.generate(test, (index){
          return Center(
            child: RaisedButton(
              color: Colors.white,
              child: Text(names[index], style:TextStyle(color: Colors.black,)),
              onPressed: (){  _save();
                selName = names[index];
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => editNote()
                ));
              },
            ),
          );
        }),
      ),
        )
    );
  }
}
