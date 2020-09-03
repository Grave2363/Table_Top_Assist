import 'package:flutter/material.dart';
import 'package:rpgcompanion/Authenticate/regester.dart';
import 'package:rpgcompanion/Home/home.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:rpgcompanion/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
class resetPass extends StatefulWidget {
  @override
  _resetPassState createState() => _resetPassState();
}

class _resetPassState extends State<resetPass> {
  final AuthSer _auth = AuthSer();
  final _formKey = GlobalKey<FormState>();
  bool load = false;
  String error = '';
  String email = '';
  String password = '';
  _save()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("Email", email);
  }
  @override
  Widget build(BuildContext context) {
    return load ?Load() : Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Reset Password'),
        actions: <Widget>[
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(onChanged: (val) {setState(() => email = val);},validator: (val) => val.isEmpty ? 'Enter an Email': null,decoration: textInputDecor.copyWith(hintText: 'Email') ),
              SizedBox(height: 20.0,),
              FlatButton( color: Colors.red, child: Text('ResetPassword'), onPressed: () async { if (_formKey.currentState.validate()){
                setState(() => load = true);
                dynamic res = await _auth.resetPass(email);
                if (res == null){
                  setState(() {
                    error = 'invalid email';
                    });
                }
              }
              },
              ),
              SizedBox(height: 15.0,),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 12.0),),
            ],
          ),
        ),
      ),
    );
  }
}
