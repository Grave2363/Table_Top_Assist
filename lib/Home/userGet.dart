import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/model/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userGet extends StatefulWidget {
  @override
  _userGetState createState() => _userGetState();
}

class _userGetState extends State<userGet> {


  _save()async
  {
    final pref = await SharedPreferences.getInstance();
    var nameList = pref.getStringList('Names');
    if (nameList == null)
    {
      nameList = List<String>();
    }

  }
  @override
  Widget build(BuildContext context) {
    final characterGet = Provider.of<List<UserInfo>>(context);
    if (characterGet != null)
      characterGet.forEach((CharSheet)
      {
       
        _save();
      });
    return Container();
  }
}
