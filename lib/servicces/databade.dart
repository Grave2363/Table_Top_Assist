import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpgcompanion/model/CharSheet.dart';
import 'package:rpgcompanion/model/UserInfo.dart';
import 'package:rpgcompanion/model/user.dart';
// ignore: camel_case_types
class databaseService {
  final String uid;
  databaseService({this.uid});
  static String collect = '';
  // collection ref
  static CollectionReference characterCollection =  Firestore.instance.collection(collect).reference();
  static CollectionReference userNameCollection =  Firestore.instance.collection(collect + "Name").reference();
  static CollectionReference userCollection =  Firestore.instance.collection("Users").reference();
  Future uploadData(String level,String classes,String strength, String intelligence, String constitution, String wisdom, String dexterity, String charisma, String name, String skills, String magic ) async{
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
      'Skills': skills
    });
  }
  Future uploadUserName(String user, String email ) async{
    return await userCollection.document(email).setData({
      'Name': user,
      'Email' : email
    });
  }
  getUserByName(String name) async
  {
    return await Firestore.instance.collection("Users").where("Name", isEqualTo: name).getDocuments();
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
  Future UploadUserInfo(String user, String email ) async{
    return await userNameCollection.document(email).setData({
      'Name': user,
      'Email' : email,
      'Uid' : uid
    });
  }
// Get the user's Name
  List<UserInfo> _UserFromSnap(QuerySnapshot snap)
  {
    return snap.documents.map((doc){
      return UserInfo(
        name: doc.data['Name']??'',
        email: doc.data['Email']??'',
        uid: doc.data['Uid']??''
      );
    }).toList();
  }

  Stream<List<UserInfo>> get user {
    return userNameCollection.snapshots().map(_UserFromSnap);
  }
}