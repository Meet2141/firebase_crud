import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/common/common.dart';
import 'package:firebase_demo/common/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../userdetail/user_detail.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

Validation validation ;
  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _password.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {

    validation = Validation();

    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Form', style: TextStyle(fontFamily:'Pacifico'),),
        centerTitle: true,
        backgroundColor: Common.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  style: TextStyle(fontFamily:'Pacifico'),
                  controller: _name,
                  validator: validation.validateName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Write Name Here'),
                  keyboardType: TextInputType.text,
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  style: TextStyle(fontFamily:'Pacifico'),
                  controller: _email,
                  validator: validation.validateEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Write Email Here'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  style: TextStyle(fontFamily:'Pacifico'),
                  validator: validation.validatePassword,
                  controller: _password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Write Password Here'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: Colors.green,
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  child: Text('Register',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily:'Pacifico'),),
                  onPressed: (){
                    getRegister();
                  },
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: Common.secondaryColor,
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  child: Text('Login Page',style: TextStyle(fontFamily:'Pacifico',fontSize: 15,color: Colors.white),),
                  onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRegister() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _email.text, password: _password.text)
        .then((currentUser) => Firestore.instance
            .collection("users")
            .document(currentUser.user.uid)
            .setData({
              "name": _name.text,
              "email": _email.text,
              "password": _password.text,
            })
            .then((result) => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetail()),
                      (_) => false),
                  Fluttertoast.showToast(
                      msg: "Registered Success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0),
                  _name.clear(),
                  _email.clear(),
                  _password.clear(),
                })
            .catchError((err) => print(err)))
        .catchError((err) => print(err));
  }

}
