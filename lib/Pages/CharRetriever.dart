import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rpgcompanion/model/CharSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterRetreval extends StatefulWidget {
  @override
  _CharacterRetrevalState createState() => _CharacterRetrevalState();
}

class _CharacterRetrevalState extends State<CharacterRetreval> {
  bool getChar = false;
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
  void setGetChar()
  {
    getChar = true;
  }
  _save()async
  {
    final pref = await SharedPreferences.getInstance();
    var nameList = pref.getStringList('Names');
    if (nameList == null)
    {
      nameList = List<String>();
    }
    final nameKey = '$nameVal';
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
      await pref.setString(skillKey, skills);
      await pref.setString(magicKey, magic);
      await pref.setString(classKey, classes);
      await pref.setString(intKey, Int);
      await pref.setString(strKey, Str);
      await pref.setString(dexKey, Dex);
      await pref.setString(constKey, Const);
      await pref.setString(wisKey, Wis);
      await pref.setString(charKey, Char);
      await pref.setString(levelKey, level);
    }
    else if (nameList.contains(nameVal))
    {
      pref.remove('$nameVal level');
      pref.remove('$nameVal magic');
      pref.remove(('$nameVal magic'));
      pref.remove('$nameVal class');
      pref.remove('$nameVal int');
      pref.remove('$nameVal str');
      pref.remove('$nameVal dex');
      pref.remove('$nameVal const');
      pref.remove('$nameVal wis');
      pref.remove('$nameVal char');
      await pref.setString(skillKey, skills);
      await pref.setString(magicKey, magic);
      await pref.setString(classKey, classes);
      await pref.setString(intKey, Int);
      await pref.setString(strKey, Str);
      await pref.setString(dexKey, Dex);
      await pref.setString(constKey, Const);
      await pref.setString(wisKey, Wis);
      await pref.setString(charKey, Char);
      await pref.setString(levelKey, level);
    }
  }
  @override
  Widget build(BuildContext context) {
    final characterGet = Provider.of<List<CharSheet>>(context);
    if (characterGet != null)
    characterGet.forEach((CharSheet)
    {
       nameVal = CharSheet.name;
       classes = CharSheet.classes;
       Int = CharSheet.intelligence;
       Str = CharSheet.strength;
       Dex = CharSheet.dexterity;
       Const = CharSheet.constitution;
       Wis = CharSheet.wisdom;
       Char = CharSheet.charisma;
       level = CharSheet.level;
       skills = CharSheet.skills;
       magic = CharSheet.magic;
       _save();
    });
    return Container();
  }
}
