import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunicationScreen extends StatefulWidget {
  final String chatRoomId;
  CommunicationScreen(this.chatRoomId);
  @override
  _CommunicationScreenState createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  TextEditingController editCon = new TextEditingController();
  Stream chatStream ;
  String User = '';
  Widget chatMessage()
  {
    return StreamBuilder (
      stream: chatStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length
            ,itemBuilder:(context, index){
              return Message(snapshot.data.documents[index].data["message"], snapshot.data.documents[index].data["sender"] == User);
        } ) : Container();
      },
    );
  }
  send(){
    if (editCon.text.isNotEmpty)
    {
    Map<String, dynamic> chatMap = { "message" : editCon.text, "sender" :User, "Time" : DateTime.now().millisecondsSinceEpoch };
    databaseService().getConversation(widget.chatRoomId, chatMap);
    }
  }
  _read()
  async {
    final pref = await SharedPreferences.getInstance();
    User = pref.getString('User');
    databaseService().getMessages(widget.chatRoomId).then((value){ setState(() {
      chatStream = value;
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
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Stack(
          children: <Widget>[
            chatMessage(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical:  14),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
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
                          child: Image.asset("assets/search.jpg")
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
  Message(this.message, this.didISend);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: didISend ? 0 : 20, right: didISend ? 20 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: didISend ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical:  5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: didISend ? [Colors.blue, Colors.blueAccent] : [Colors.red, Colors.redAccent]
          ),
          borderRadius: didISend ?
          BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20) ) :
          BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
           child: Text(message, style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
