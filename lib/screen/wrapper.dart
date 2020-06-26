import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/Authenticate/authenticate.dart';
import 'package:rpgcompanion/Home/home.dart';
import 'package:rpgcompanion/model/user.dart';
class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return authenticate();
    }
    else{
      return home();
    }
  }
}
