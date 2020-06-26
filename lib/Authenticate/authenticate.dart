import 'package:flutter/material.dart';
import 'package:rpgcompanion/Authenticate/regester.dart';
import 'package:rpgcompanion/Authenticate/signIn.dart';
class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn =  !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){return signIn(toggleView: toggleView);}
    else{ return Regester(toggleView: toggleView);}
  }
}
