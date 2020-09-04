import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpgcompanion/model/CharSheet.dart';
// ignore: camel_case_types
class databaseService {
  final String uid;
  databaseService({this.uid});
  static String collect = '';
  // collection ref
  static CollectionReference characterCollection =  Firestore.instance.collection(collect).reference();
  Future uploadData( int charNum,String level,String classes,String strength, String intelligence, String constitution, String wisdom, String dexterity, String charisma, String name, String skills, String magic ) async{
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
  void setCollect(String string)
  {
    collect = string;
  }
  //char list from snapshot
  List<CharSheet> _charListFromSnap(QuerySnapshot snap)
  {
    return snap.documents.map((doc){
      return CharSheet(
       name: doc.data['name']??'',
       level: doc.data['level']?? '',
       strength: doc.data['strength']??'',
       intelligence: doc.data['intelligence']??'',
       constitution: doc.data['constitution']??'',
       wisdom: doc.data['wisdom']??'',
       dexterity: doc.data['dexterity']??'',
       charisma: doc.data['charisma']??'',
       magic: doc.data['magic']??'',
       skills: doc.data['skills']??'',
        classes: doc.data['classes']?? ''
      );
    }).toList();
  }

  //get stream
Stream<List<CharSheet>> get characters {
    return characterCollection.snapshots().map(_charListFromSnap);
}
}