import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpgcompanion/model/CharSheet.dart';

// ignore: camel_case_types
class databaseService {
  final String uid;
  databaseService({this.uid});
  static String collect = '';
  // collection ref
  static CollectionReference characterCollection =  Firestore.instance.collection(collect).reference();
  static CollectionReference userCollection =  Firestore.instance.collection("Users").reference();
  Future uploadData(String level,String classes,String strength, String intelligence, String constitution, String wisdom, String dexterity, String charisma, String name, String skills, String magic, String feats ) async{
    return await characterCollection.document(name).setData({
      'Name': name,
      'Level' : level,
      'Classes' : classes,
      'Strength' : strength,
      'Intelligence' : intelligence,
      'Constitution' : constitution,
      'Wisdom' : wisdom,
      'Dexterity' : dexterity,
      'Charisma' : charisma,
      'Magic': magic,
      'Skills': skills,
      'Feats': feats
    });
  }
  Future uploadUserName(String user, String email, String deviceToken ) async{
    return await userCollection.document(email).setData({
      'Name': user,
      'Email' : email,
      'DeviceId': deviceToken,
      'Profile Pic': null
    });
  }
  Future updateUser(String user, String email, String deviceToken, String bio ) async{
    return await userCollection.document(email).setData({
      'Name': user,
      'Email' : email,
      'DeviceId': deviceToken,
      'Profile Pic': null,
      'User_Bio': bio
    });
  }
  getUserByName(String name) async
  {
    return await Firestore.instance.collection("Users").where("Name", isGreaterThanOrEqualTo: name).getDocuments();
  }
  getOtherID(String room)async
  {
    return await Firestore.instance.collection("ChatRoom").where("ChatRoomId", isEqualTo: room).getDocuments();
  }
  createChat(String chatId, chatMap)
  {
    Firestore.instance.collection("ChatRoom").document(chatId).setData(chatMap).catchError((e){print(e.toString());});
  }
  void setCollect(String string)
  {
    collect = string;
  }
  //char list from snapshot
  List<CharSheet> _charListFromSnap(QuerySnapshot snap)
  {
    return snap.documents.map((doc){
      return CharSheet(
       name: doc.data['Name']??'',
       level: doc.data['Level']?? '',
       strength: doc.data['Strength']??'',
       intelligence: doc.data['Intelligence']??'',
       constitution: doc.data['Constitution']??'',
       wisdom: doc.data['Wisdom']??'',
       dexterity: doc.data['Dexterity']??'',
       charisma: doc.data['Charisma']??'',
       magic: doc.data['Magic']??'',
       skills: doc.data['Skills']??'',
        classes: doc.data['Classes']?? ''
      );
    }).toList();
  }

  //get stream
Stream<List<CharSheet>> get characters {
    return characterCollection.snapshots().map(_charListFromSnap);
}
getConversation(String chatId, messageMap)
{
  Firestore.instance.collection("ChatRoom").document(chatId).collection("Chat").add(messageMap).catchError((e){print("Error "+e.toString());});
}
setDeviceList(String chatId, deviceI1, deviceID2)
{
  Firestore.instance.collection("ChatRoom").document(chatId).collection("Devices").add(deviceI1).catchError((e){print("Error "+e.toString());});
  Firestore.instance.collection("ChatRoom").document(chatId).collection("Devices").add(deviceID2).catchError((e){print("Error "+e.toString());});
}
getDeviceID(String chatId)async
{
  return  await Firestore.instance.collection("ChatRoom").document(chatId).collection("Devices").snapshots();
}
   getMessages(String chatId) async
  {
    return  await Firestore.instance.collection("ChatRoom").document(chatId).collection("Chat").orderBy("Time", descending: false).snapshots();
  }
   getRooms(String user) async
  {
    return await Firestore.instance.collection("ChatRoom").where("Users", arrayContains: user).snapshots();
  }
}