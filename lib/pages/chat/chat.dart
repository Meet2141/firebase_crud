import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/common/common.dart';
import 'package:flutter/material.dart';



class UserChat extends StatefulWidget {
  String cid;
  UserChat({this.cid});
  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final _db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Common.secondaryColor,
        title: Text(
          'Chat with FireBase',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
