import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/common/common.dart';
import 'package:firebase_demo/pages/edit/edit_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  String fid;
  String address, pinCode, phone;

  FetchData({this.fid, this.address, this.pinCode, this.phone});

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  final _db = Firestore.instance;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Common.secondaryColor,
        title: Text(
          'Fetch Data',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db
              .collection("users")
              .document(widget.fid)
              .collection("subuser")
              .orderBy('phone')
              .limit(10)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Loading..."),
                    SizedBox(
                      height: 50.0,
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () async {
                      var firebaseUser =
                          await FirebaseAuth.instance.currentUser();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditData(
                                    eid: firebaseUser.uid,
                                    documentSnapshot:
                                        snapshot.data.documents[index],
                                  )));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Phone: ${snapshot.data.documents[index].data['phone']}',
                              style: TextStyle(fontFamily: 'Pacifico'),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Address: ${snapshot.data.documents[index].data['address']}',
                              style: TextStyle(fontFamily: 'Pacifico'),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'PinCode: ${snapshot.data.documents[index].data['pinCode']}',
                              style: TextStyle(fontFamily: 'Pacifico'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
