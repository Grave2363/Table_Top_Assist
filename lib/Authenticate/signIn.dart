import 'package:flutter/material.dart';
import 'package:rpgcompanion/Authenticate/ResetPass.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/servicces/push_notification.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:rpgcompanion/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: camel_case_types
class signIn extends StatefulWidget {
  final Function toggleView;
  signIn({this.toggleView });

  @override
  _signInState createState() => _signInState();
}

// ignore: camel_case_types
class _signInState extends State<signIn> {
  final AuthSer _auth = AuthSer();
  final _formKey = GlobalKey<FormState>();
  final _emailControler = TextEditingController();
  final PushNotificationService push = PushNotificationService();
  bool load = false;
  String error = '';
  String email = '';
  String password = '';
  _save()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("Email");
    await pref.setString("Email", email);
  }
  @override
  void initState() {
    push.initalise();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load ?Load() : Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(onChanged: (val) {setState(() => email = val);},controller: _emailControler,validator: (val) => val.isEmpty ? 'Enter an Email': null,decoration: textInputDecor.copyWith(hintText: 'Email') ),
                SizedBox(height: 20.0,),
                TextFormField(onChanged: (val){setState(() => password = val);}, obscureText: true,validator: (val) => val.length < 4  ? 'Enter at least 4 characters': null, decoration: textInputDecor.copyWith(hintText: 'Password'),),
                SizedBox(height: 20.0,),
                FlatButton( color: Colors.red, child: Text('Sign In'), onPressed: () async { if (_formKey.currentState.validate()){
                  setState(() => load = true);
                  _save();
                  dynamic res = await _auth.signInEmailAndPass(email, password);
                  if (res == null){
                    setState(() {
                      error = 'invalid credentials';
                      load = false;});

                  }
                }
                },
                ),
                SizedBox(height: 20.0,),
                FlatButton(
                  color: Colors.red,
                  child: Text('Anon Sign in'),
                  onPressed: () async {
                    dynamic res =  await _auth.signAnon();
                    if (res == null){
                      print('error');
                    }
                    else{
                      print('signed In Anon');
                      print(res.uid);
                    }
                  },
                ),
                SizedBox(height: 20.0,),
                FlatButton(
                  color: Colors.red,
                  child: Text('Reset Password'),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => resetPass()));
                  },
                ),
                SizedBox(height: 15.0,),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 12.0),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
