import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/model/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class userGet extends StatefulWidget {
  @override
  _userGetState createState() => _userGetState();
}

// ignore: camel_case_types
class _userGetState extends State<userGet> {

String userName = '';
  _save()async
  {
    final pref = await SharedPreferences.getInstance();
    pref.setString("User", userName);
  }
  @override
  Widget build(BuildContext context) {
    final userGet = Provider.of<List<UserInfo>>(context);
    if (userGet != null)
      // ignore: non_constant_identifier_names
      userGet.forEach((UserInfo)
      {
        userName = UserInfo.name;
        print("Username "+userName);
        _save();
      });
    return Container();
  }
}
