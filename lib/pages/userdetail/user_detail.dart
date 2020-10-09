import 'package:firebase_demo/common/common.dart';
import 'package:firebase_demo/common/validation.dart';
import 'package:firebase_demo/firebaseapi/firebaseapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class UserDetail extends StatefulWidget {
  String uid;

  UserDetail({this.uid});

  @override
  UserDetailState createState() => UserDetailState();
}

class UserDetailState extends State<UserDetail> {
  Validation validation;
  FireBaseApi fireBaseApi;
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pinCode = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phone.dispose();
  }
  @override
  void initState() {
    fireBaseApi = FireBaseApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validation = Validation();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
        backgroundColor: Common.secondaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 70),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: validation.validateMobile,
                    controller: _phone,
                    style: TextStyle(fontFamily:'Pacifico'),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'Write Mobile Number Here'),
                    keyboardType: TextInputType.number,
                  ),
                ),
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
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    style: TextStyle(fontFamily:'Pacifico'),
                    controller: _pinCode,
                    validator: validation.validateCode,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pincode',
                        hintText: 'Enter Pincode Here'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  color: Colors.green,
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    child: Text(
                      'User Additional Details',
                      style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Pacifico'),
                    ),
                    onPressed: () {
                      _validateInputs();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
      String uid = widget.uid;
      String phone = _phone.text;
      String address = _address.text;
      String pinCode = _pinCode.text;
      fireBaseApi.addSubUser(uid,phone,address,pinCode);
      _phone.clear();
      _address.clear();
      _pinCode.clear();
    }
  }


}
