import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/servicces/auth.dart';
import 'package:rpgcompanion/servicces/databade.dart';
import 'package:rpgcompanion/shared/const.dart';
import 'package:rpgcompanion/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Regester extends StatefulWidget {
  final Function toggleView;
  Regester({this.toggleView });
  @override
  _RegesterState createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  final AuthSer _auth = AuthSer();
  final _formKey = GlobalKey<FormState>();
  FirebaseMessaging FBM = new FirebaseMessaging();
  String userToken = '';
  // ignore: non_constant_identifier_names
  String User = '';
  final _userController = TextEditingController();
  bool load = false;
  String email = '';
  String password = '';
  String error = '';
  _save()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("Email");
    await pref.setString("Email", email);
    await pref.setString('User', User);
   // await pref.setString('DeviceToken', userToken);
  }
  @override
  void initState() {
    FBM.getToken().then((token){
      userToken = token;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load ? Load(): Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Sign In'))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextField(onChanged: (val) {setState(() => User = val);},controller: _userController ,decoration: textInputDecor.copyWith(hintText: 'Profile Name'), ),
                SizedBox(height: 20.0,),
                TextFormField(onChanged: (val) {setState(() => email = val);},validator: (val) => val.isEmpty ? 'Enter an Email': null,decoration: textInputDecor.copyWith(hintText: 'Email'),),
                SizedBox(height: 20.0,),
                TextFormField(onChanged: (val){setState(() => password = val);}, obscureText: true,validator: (val) => val.length < 4  ? 'Enter at least 4 characters': null,decoration: textInputDecor.copyWith(hintText: 'Password'),),
                SizedBox(height: 20.0,),
                FlatButton( color: Colors.red, child: Text('Register'), onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => load = true);
                    databaseService().setCollect(email);
                    databaseService().uploadUserName(email, _userController.text);
                    dynamic res = await _auth.regesterEmailAndPass(email, password);
                    _save();
                    if (res == null){
                      setState(() {
                        error = 'please supply some valid email';
                        load = false;});
                    }
                  }
                },),
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
