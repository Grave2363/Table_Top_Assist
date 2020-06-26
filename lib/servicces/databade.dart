import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
class databaseService {
  final String uid;
  databaseService({this.uid});
  // collection ref
  final CollectionReference characterCollection = Firestore.instance.collection('Characters');
  Future uploadData(File img, String strength, String intelligence, String constitution, String wisdom, String dexterity, String charisma, String name, String skills, String magic ) async{
    return await characterCollection.document(uid).setData({
      'Name': name,
      'Pic' : img ,
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
  //get stream
Stream<QuerySnapshot> get characters {
    return characterCollection.snapshots();
}
}