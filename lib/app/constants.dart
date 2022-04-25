import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConstantClass{
  // static const baseUrlConstant = "http://192.168.100.23:3000";
  static const baseUrlConstant = "https://server.rno-one.com";

 static void showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
    );
  }
}