import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/LoginAndRegister/LoginScreen.dart';
import 'package:mydrive/MainDashboard/DashboardScreen.dart';
import 'package:passcode/passcode.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Helper/CustomButton.dart';

class PasscodeInitialScreen extends StatefulWidget {
  @override
  _PasscodeInitialScreenState createState() => _PasscodeInitialScreenState();
}

class _PasscodeInitialScreenState extends State<PasscodeInitialScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String mypasscode = "";
  StreamController<ErrorAnimationType> errorController;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Passcode",
                  style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [CustomColors().mygreenboxshadow],
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: width * 0.09),
                  child: Column(
                    children: <Widget>[
                      PinCodeTextField(
                        autoFocus: true,
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        obscureText: true,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 4) {
                            return "Enter four digit passscode";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          selectedFillColor: Colors.white,
                          activeColor: Color(0xFF4F44FF),
                          borderRadius: BorderRadius.circular(5),
                          activeFillColor:
                              hasError ? Colors.orange : Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        //   textStyle: TextStyle(fontSize: 20, height: 1.6),
                        //   backgroundColor: Colors.blue.shade50,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          print(v);
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          setState(() {
                            mypasscode = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              mypasscode.toString().length == 4
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: CustomButton().customButton(
                          width: width,
                          title: "Proceed",
                          myroute: () async {
                            final storage = new FlutterSecureStorage();
                            String value = await storage.read(key: "Passcode");
                            String status =
                                await storage.read(key: "LoginStatus");
                            print(value);
                            print(mypasscode);
                            if (mypasscode != null ||
                                mypasscode != "" ||
                                value != null) {
                              if (value == mypasscode) {
                                if (status == "true") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardScreen()));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                }
                              } else {
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Passcode mismatch"));
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                              }
                              print("done");
                            }
                            print("not");
                          }),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
