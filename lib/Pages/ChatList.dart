import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatSearch extends StatefulWidget {
  @override
  _ChatSearchState createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  TextEditingController editCon = new TextEditingController();
  QuerySnapshot serchSnap;
  String usersName  = '';
  makeChat(String username)
  {
    List<String> users = [username, usersName];
  }
  Widget searchList()
  {
    return serchSnap != null ? ListView.builder(itemCount: serchSnap.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
      return SearchBox( userName: serchSnap.documents[index].data["Name"], email: serchSnap.documents[index].data["Email"],);
    },): Container() ;
  }
  doSearch() {
    databaseService().getUserByName(editCon.text).then((val){setState(() {
      serchSnap = val;
    });});
  }
  _read() async
  {
    final pref = await SharedPreferences.getInstance();
    usersName = pref.getString('User');
  }
  @override
  void initState() {
   _read();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Chat Search'),
        actions: <Widget>[
        ],
      ),body: Container(
       color: Colors.blueGrey,
        child: Column(
         children: <Widget>[
          Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical:  14),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                      controller: editCon,
                      decoration: InputDecoration(
                        hintText: "Search user",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                GestureDetector(
                onTap: (){
                  doSearch();
                },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.grey,
                            Colors.blueGrey,]
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Image.asset("assets/search.jpg")
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }


}
class SearchBox extends StatelessWidget {
  final String userName;
  final String email;
  SearchBox({this.userName, this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName, ),
              Text(email),
            ],
          ),
          Spacer(),
          Container(
           decoration: BoxDecoration(
             color: Colors.red,
             borderRadius: BorderRadius.circular(40),
           ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Message"),
          ),
        ],
      ),
    );
  }
}
