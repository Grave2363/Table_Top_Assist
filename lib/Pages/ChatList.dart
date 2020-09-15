import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Communicate.dart';

class ChatSearch extends StatefulWidget {
  @override
  _ChatSearchState createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  TextEditingController editCon = new TextEditingController();
  QuerySnapshot searchSnap;
  String myName  = '';
  String userToken ='';

  makeChat({String username, String otherDevice})
  {
    if (username != myName){
      String roomId = getChatRoom(username, myName);
      List<String> users = [username, myName];
      List<String> DeviceIds = [otherDevice, userToken];
      Map<String, dynamic> roomMap = {
        "Users" : users,
        "ChatRoomId" : roomId,
        "Sender": myName,
        "devices": DeviceIds
      };
      databaseService().createChat(roomId, roomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => CommunicationScreen(roomId)
      ));
    }
  }
  Widget searchList()
  {
    return searchSnap != null ? ListView.builder(itemCount: searchSnap.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
      return SearchBox( userName: searchSnap.documents[index].data["Name"], email: searchSnap.documents[index].data["Email"],otherUserId: searchSnap.documents[index].data["DeviceId"]);
    },): Container() ;
  }
  doSearch() {
    databaseService().getUserByName(editCon.text).then((val){setState(() {
      searchSnap = val;
    });});
  }
  _read() async
  {
    final pref = await SharedPreferences.getInstance();
    myName = pref.getString('User');
    userToken = pref.getString('DeviceToken');
  }
  @override
  void initState() {
   _read();
    super.initState();
  }
  // ignore: non_constant_identifier_names
  Widget SearchBox({String userName, String email, String otherUserId})
  {
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
          GestureDetector(
            onTap: (){
              makeChat( username : userName, otherDevice: otherUserId);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Message"),
            ),
          ),
        ],
      ),
    );
  }
  getChatRoom(String n1, String n2)
  {
    if (n1.substring(0,1).codeUnitAt(0) > n2.substring(0,1).codeUnitAt(0))
    {
      return "$n2\_$n1";
    }else{
      return "$n1\_$n2";
    }
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
      ),
      body: Container(
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
                      style: TextStyle(color: Colors.white),
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
                    child: Image.asset("assets/searchIcon.png")
                ),
                ),
              ],
            ),
          ),
           searchList(),
        ],
      ),
    ),
    );
  }


}
