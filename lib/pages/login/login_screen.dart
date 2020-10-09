import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/common/common.dart';
import 'package:firebase_demo/common/validation.dart';
import 'package:firebase_demo/pages/register/signup.dart';
import 'package:firebase_demo/pages/userdetail/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home/homeScreen.dart';
import 'google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  HomeScreen uid;

  LoginScreen({this.uid});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Validation validation;
  bool _obscureText = true;

  void _passCheck() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    validation = Validation();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
        backgroundColor: Common.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 70),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: validation.validateEmail,
                  style: TextStyle(fontFamily: 'Pacifico'),
                  controller: _emailController,
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
                  style: TextStyle(fontFamily: 'Pacifico'),
                  validator: validation.validatePassword,
                  obscureText: _obscureText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: Container(
                        child: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: _passCheck,
                        ),
                      ),
                      hintText: 'Write Password Here'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: Colors.green,
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                  onPressed: () {
                    login();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: Common.secondaryColor,
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  child: Text(
                    'Sign-Up Page',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Wrap(
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      label: Text(
                        'Sign-In',
                        style: TextStyle(
                            color: Colors.red, fontFamily: 'Pacifico'),
                      ),
                      onPressed: () {
                        signInWithGoogle().whenComplete(() =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDetail())));
                      },
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Sign-In',
                        style: TextStyle(
                            color: Colors.blue, fontFamily: 'Pacifico'),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((currentUser) => Firestore.instance
            .collection("users")
            .document(currentUser.user.uid)
            .get()
            .then((DocumentSnapshot result) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          hid: currentUser.user.uid,
                        ))))
            .catchError((err) => print(err)))
        .catchError((err) => print(err));
  }
}
