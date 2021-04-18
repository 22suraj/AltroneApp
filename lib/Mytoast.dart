import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mydrive/Helper/CustomColors.dart';
class MyToast {
  void mytoast(_msg) {
    Fluttertoast.showToast(
      msg: _msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: CustomColors().mygreencolorshade600,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
