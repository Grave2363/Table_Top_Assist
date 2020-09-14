import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rpgcompanion/servicces/databade.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatList.dart';
import 'Communicate.dart';

// ignore: camel_case_types
class listOfChats extends StatefulWidget {
  @override
  _listOfChatsState createState() => _listOfChatsState();
}

// ignore: camel_case_types
class _listOfChatsState extends State<listOfChats> {
  //AuthSer _auth = AuthSer();
  // ignore: non_constant_identifier_names
  String User = '';
  Stream chats;
  Widget chatList()
  {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData?  ListView.builder(itemCount: snapshot.data.documents.length,shrinkWrap: true,itemBuilder: (context, index){
          return ChatListDisplay(
            snapshot.data.documents[index].data["ChatRoomId"].toString().replaceAll("_", "").replaceAll(User, ""), snapshot.data.documents[index].data["ChatRoomId"]
          );
        }) : Container();
      },
    );
  }
  _read()
  async {
    final pref = await SharedPreferences.getInstance();
    User = pref.getString('User');
    databaseService().getRooms(User).then((value){ setState(() {
      chats = value;
    });});
  }
  @override
  void initState() {
    _read();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('RPG Companion'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.search),
        label: Text('Search Users'),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatSearch()
              ));},
          ) ,
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            chatList()
          ],
        ),
      ) ,

    );
  }
}
class ChatListDisplay extends StatelessWidget {
  final String otherName;
  final String chatRoomId;
  ChatListDisplay(this.otherName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommunicationScreen(chatRoomId)
        ));
      },
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text("${otherName.substring(0,1).toUpperCase()}.",
              style: TextStyle(color: Colors.white),),
            ),
            SizedBox(width: 10,),
            Text(otherName, style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
