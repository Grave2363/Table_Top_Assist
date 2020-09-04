import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/model/CharSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterRetreval extends StatefulWidget {
  @override
  _CharacterRetrevalState createState() => _CharacterRetrevalState();
}

class _CharacterRetrevalState extends State<CharacterRetreval> {
  String nameVal = '';
  String classes = '';
  String Int = '';
  String Str = '';
  String Dex = '';
  String Const = '';
  String Wis = '';
  String Char = '';
  String level = '';
  String skills = '';
  String magic = '';
  _save()async
  {
    final pref = await SharedPreferences.getInstance();
    var nameList = pref.getStringList('Names');
    if (nameList == null)
    {
      nameList = List<String>();
    }
    final nameKey = '$nameVal';
    final ingKey = '$nameVal img';
    final skillKey = '$nameVal skill';
    final magicKey = '$nameVal magic';
    final classKey = '$nameVal class';
    final intKey = '$nameVal int';
    final strKey = '$nameVal str';
    final dexKey = '$nameVal dex';
    final constKey = '$nameVal const';
    final wisKey = '$nameVal wis';
    final charKey = '$nameVal char';
    final levelKey = '$nameVal level';
    if (!nameList.contains(nameVal))
    {
      nameList.add(nameVal);
      await pref.setStringList("Names", nameList);
      print('Saved name $nameVal');
    }
  }
  @override
  Widget build(BuildContext context) {
    final characterGet = Provider.of<List<CharSheet>>(context);

    return Container();
  }
}
