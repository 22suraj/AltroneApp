import 'package:flutter/material.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class CustomLeadingIcon {
  Widget customLeadingIcon({icon, width, onpressed}) {
    return Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(width * 0.1),
      child: CircleAvatar(
        backgroundColor: CustomColors().mygreencolorshade600,
        child: IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: onpressed,
        ),
      ),
    );
  }
}
