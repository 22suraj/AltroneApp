import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomColors {
  //LINEAR GRADIENT
  LinearGradient greencolorlineargradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topRight,
    colors: <Color>[
      Colors.blue.shade800,
      Color.fromARGB(255, 0, 212, 201),
    ],
  );

  //GREEN SHADE
  Color mygreencolorshade600 = Colors.blue.shade600;

  //GREEN BOX SHADOW
  BoxShadow mygreenboxshadow = BoxShadow(
    color: Colors.blue.shade800,
    spreadRadius: 1,
    blurRadius: 15,
    offset: Offset(0, 10),
  );

  //GREN SHADE 300
  Color greencolorshade300 = Colors.blue.shade300;

  //
  Gradient customlineargradient(Color color1, Color color2, Color color3,
      Color color4, Color color5, Color color6, Color color7) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        color1,
        color2,
        color3,
        color4,
        color5,
        color6,
        color7,
      ],
    );
  }
}
