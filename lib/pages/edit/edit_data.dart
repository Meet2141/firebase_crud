import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/common/common.dart';
import 'package:firebase_demo/common/validation.dart';
import 'package:firebase_demo/pages/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EditData extends StatefulWidget {
  String eid;
  DocumentSnapshot documentSnapshot;

  EditData({this.eid, this.documentSnapshot});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _db = Firestore.instance;
  Validation validation;
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pinCode = TextEditingController();

  @override
  void initState() {
    //_getData();

    print(widget.documentSnapshot.documentID);
    setState(() {
      _pinCode.text = widget.documentSnapshot.data['pinCode'];
      _address.text = widget.documentSnapshot.data['address'];
      _phone.text = widget.documentSnapshot.data['phone'];
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phone.dispose();
    _address.dispose();
    _pinCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    validation = Validation();
    return Scaffold(
      appBar: AppBar(
        title: Text('Editing Data', style: TextStyle(fontFamily:'Pacifico'),),
        centerTitle: true,
        backgroundColor: Common.secondaryColor,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    style: TextStyle(fontFamily:'Pacifico'),
                    controller: _phone,
                    validator: validation.validateMobile,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'Write Mobile Number Here'),
                    keyboardType: TextInputType.number,
                  ),
                ), //phone
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    style: TextStyle(fontFamily:'Pacifico'),
                    controller: _address,
                    validator: validation.validateAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Write Address  Here'),
                    keyboardType: TextInputType.text,
                  ),
                ), //address
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    style: TextStyle(fontFamily:'Pacifico'),
                    controller: _pinCode,
                    validator: validation.validatePincode,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pincode',
                        hintText: 'Enter Pincode Here'),
                    keyboardType: TextInputType.number,
                  ),
                ), //pinCode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton.icon(
                      color: Colors.blue,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white,fontFamily: 'Pacifico'),
                      ),
                      onPressed: () {
                        _validateInputs();
                      },
                    ),
                    FlatButton.icon(
                      color: Colors.red,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
                      ),
                      onPressed: () {
                        _getDelete();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> editData() async {
    await _db
        .collection("users")
        .document(widget.eid)
        .collection("subuser")
        .document(widget.documentSnapshot.documentID)
        .updateData({
          "phone": _phone.text,
          'address': _address.text,
          'pinCode': _pinCode.text,
        })
        .then((documentReference) {})
        .catchError((e) {
          print(e);
        });
  }

  Future<void> _getDelete() async {
    _db
        .collection("users")
        .document(widget.eid)
        .collection('subuser')
        .document(widget.documentSnapshot.documentID)
        .delete();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    Fluttertoast.showToast(
        msg: "User Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }



  void _validateInputs() {
    if (_phone.text.isEmpty || _address.text.isEmpty || _pinCode.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Enter detail',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      editData();
      Fluttertoast.showToast(
          msg: 'Edited Data Submit',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
