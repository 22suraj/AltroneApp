import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomButton.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class VerificationScreen extends StatefulWidget {
  String email;
  VerificationScreen(this.email);
  @override
  _VerificationScreenState createState() =>
      _VerificationScreenState(this.email);
}

class _VerificationScreenState extends State<VerificationScreen> {
  String email;
  _VerificationScreenState(this.email);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.png"),
            alignment: Alignment.center),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/llogo.png"),
              radius: MediaQuery.of(context).size.width * 0.2,
              backgroundColor: Colors.blue,
            ),
            /*Container(
                  child: Image.asset("assets/smiling_attendant.png"),
                ),*/
            SizedBox(
              height: 10,
            ),
            Divider(),
            Container(
              //  margin: EdgeInsets.symmetric(vertical: width * 0.1),
              child: Text(
                "Email Verification",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: width * 0.08),
                ),
              ),
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [CustomColors().mygreenboxshadow],
              ),
              margin: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.08, vertical: width * 0.09),
                child: Column(
                  children: <Widget>[
                    Text(
                      "An email has been sent to ${email},\nplease verify",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton().customButton(
                        width: width,
                        title: "Continue",
                        myroute: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
          ],
        ),
      ),
    ));
  }
}
