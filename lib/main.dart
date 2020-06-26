import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/model/user.dart';
import 'package:rpgcompanion/screen/wrapper.dart';
import 'package:rpgcompanion/servicces/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthSer().user,
      child: MaterialApp(
        home: wrapper(),
      ),
    );
  }
}

