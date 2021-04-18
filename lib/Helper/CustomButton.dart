import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class CustomButton {
  Widget customButton({width, title, myroute}) {
    return MaterialButton(
      elevation: 15,
      textColor: Colors.white,
      color: CustomColors().mygreencolorshade600,
      minWidth: width,
      child: Text(title),
      height: width * 0.14,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      onPressed:
        myroute
      
    );
  }
}
