import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Common{
static String user ='user';
static String subuser= 'subuser';
static Color primaryColor = Color(0xFF00F58D);
static Color secondaryColor = Color(0xFF006572);



 static contactAddedToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
}