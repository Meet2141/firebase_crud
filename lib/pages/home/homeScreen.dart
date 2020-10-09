import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/common/common.dart';
import 'package:firebase_demo/pages/chat/chat.dart';
import 'package:firebase_demo/pages/fetch/fetch.dart';
import 'package:firebase_demo/pages/login/login_screen.dart';
import 'package:firebase_demo/pages/userdetail/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  String hid;

  HomeScreen({this.hid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen', style: TextStyle(fontFamily:'Pacifico'),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              logOut();
            },
          )
        ],
        backgroundColor: Common.secondaryColor,
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            final value = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Are you sure you want to exit?', style: TextStyle(fontFamily:'Pacifico'),),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No', style: TextStyle(fontFamily:'Pacifico'),),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text('Yes, exit', style: TextStyle(fontFamily:'Pacifico'),),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                });
            return value == true;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 200),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        color:Common.primaryColor,
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          child: Text(
                            'User Details',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Pacifico'),
                          ),
                          onPressed: () {
                            _userDetailAdd();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        color: Colors.green,
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          child: Text(
                            'Fetch Data',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Pacifico'),
                          ),
                          onPressed: () {
                            _onFetch();
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
                            'Chat using FireBase',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Pacifico'),
                          ),
                          onPressed: () {
                            _userChat();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFetch() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FetchData(
                  fid: firebaseUser.uid,
                )));
  }

  void _userDetailAdd() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetail(
                  uid: firebaseUser.uid,
                )));
  }
  void _userChat() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserChat(
              cid: firebaseUser.uid,
            )));
  }

  Future<LoginScreen> logOut() async {
    await FirebaseAuth.instance.signOut();
    runApp(MaterialApp(
      home: LoginScreen(),
    ));
  }
}
