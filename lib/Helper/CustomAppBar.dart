import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class CustomAppBar {
  Widget TopCustomAppBar(width, height, title) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.09),
      child: AppBar(
        elevation: 9,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(width * 0.15),
              ),
              gradient: CustomColors().greencolorlineargradient),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(width * 0.25),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.lato(
            //   fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
