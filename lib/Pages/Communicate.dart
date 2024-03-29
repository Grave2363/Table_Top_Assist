import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommunicationScreen extends StatefulWidget {
  final String chatRoomId;
  CommunicationScreen({ this.chatRoomId});
  @override
  _CommunicationScreenState createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  TextEditingController editCon = new TextEditingController();
  Stream chatStream ;
  Stream IDStream;
  String userToken ='';
  String otherToken = '';
  // ignore: non_constant_identifier_names
  String User = '';
  String roomName = '';
  Widget chatMessage()
  {
    return StreamBuilder (
      stream: chatStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length
            ,itemBuilder:(context, index){
              Timestamp stamp = snapshot.data.documents[index].data["Time Sent"];
              final oneMinaAgo = stamp.toDate().subtract(new Duration(minutes: 1));
              return Message(snapshot.data.documents[index].data["message"],timeago.format(oneMinaAgo),snapshot.data.documents[index].data["sender"] == User || snapshot.data.documents[index].data["sender_Id"] == userToken);
        } ) : Container();
      },
    );
  }
  send(){
    if (editCon.text.isNotEmpty)
    {
    Map<String, dynamic> chatMap = { "message" : editCon.text, "sender" :User,"sender_Id": userToken , "Target_ID": otherToken,"Time" : DateTime.now().millisecondsSinceEpoch /*for sorting messages */,"Time Sent" :  DateTime.now() };
    databaseService().getConversation(widget.chatRoomId, chatMap);
    }
  }
  _read()
  async {
    final pref = await SharedPreferences.getInstance();
    User = pref.getString('User');
    userToken = pref.getString('DeviceToken');
    databaseService().getMessages(widget.chatRoomId).then((value){ setState(() {
      chatStream = value;
    });});
    String temp = '';
    temp = widget.chatRoomId;
    roomName = temp.replaceAll("_", "").replaceAll(User, "");
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
        title: Text(roomName),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 70),
              child:  chatMessage(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical:  10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(color: Colors.white),
                          controller: editCon,
                          decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: TextStyle(
                                color: Colors.white
                            ),
                            border: InputBorder.none,
                          ),
                        )),
                    GestureDetector(
                      onTap: (){
                        send();
                        editCon.text = '';
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
                          child: Icon(Icons.send)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Message extends StatelessWidget {
  final String message;
  final bool didISend;
  final String timeSent;
  Message(this.message,this.timeSent,this.didISend);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: didISend ? 0 : 20, right: didISend ? 20 : 0, bottom: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      alignment: didISend ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical:  10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: didISend ? [Colors.blue, Colors.blueAccent] : [Colors.red, Colors.redAccent]
          ),
          borderRadius: didISend ?
          BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20) ) :
          BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
           child: Column(
             children: <Widget>[
               Text(timeSent, style: TextStyle(fontSize: 12, )),
               Text(message, style: TextStyle(fontSize: 20)),
             ],
           ),
      ),
    );
  }
}
