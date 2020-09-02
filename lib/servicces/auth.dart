import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rpgcompanion/model/user.dart';
import 'package:rpgcompanion/servicces/databade.dart';
class AuthSer {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAnon = false;
  //auth user change
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userfirebaseUser);
  }
  //anon
  Future signAnon () async {
    try{
     AuthResult res = await _auth.signInAnonymously();
     FirebaseUser user = res.user;
     print(user.email);
     isAnon = true;
     return _userfirebaseUser(user);
    }
    catch(e){
      print('error');
      print(e.toString());
      return null;
    }
  }
  // make user obj
  User _userfirebaseUser (FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }
  //email & pass sign in
  Future signInEmailAndPass(String email, String pass) async {
    try{
      AuthResult res = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = res.user;
      return _userfirebaseUser(user);
    }catch(e){
      print('error');
      print(e.toString());
    }
  }
  //regester
  Future regesterEmailAndPass(String email, String pass) async {
    try{
      AuthResult res = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = res.user;
      return _userfirebaseUser(user);
    }catch(e){
      print('error');
      print(e.toString());
    }
  }
  bool IsUserAnon()
  {
    return isAnon;
  }
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}