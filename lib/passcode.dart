import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Mytoast.dart';
import 'package:passcode/passcode.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Helper/CustomButton.dart';

class PasscodeScreen extends StatefulWidget {
  @override
  _PasscodeScreenState createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  String mypasscode = "";
  StreamController<ErrorAnimationType> errorController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.blue.shade800,
        title: Text(
          "Set Passcode",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*  PasscodeTextField(
              onTextChanged: (passcode) {
                setState(() {
                  mypasscode = passcode;
                });
              },
              totalCharacters: 4,
              borderColor: Colors.black,
              passcodeType: PasscodeType.number,
            ),*/
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
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton().customButton(
                  width: width,
                  title: "Remove Passcode",
                  myroute: () async {
                    print(mypasscode.toString().length);
                    print(mypasscode);

                    if (mypasscode != null || mypasscode != "") {
                      final storage = new FlutterSecureStorage();
                      await storage.write(
                          key: "PasscodeStatus", value: "false");
                      print("done");
                      MyToast().mytoast("Passcode Removed");
                      Navigator.pop(context);
                    }

                    print("not");
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            mypasscode.toString().length == 4
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: CustomButton().customButton(
                        width: width,
                        title: "Set",
                        myroute: () async {
                          print(mypasscode.toString().length);
                          print(mypasscode);

                          if (mypasscode != null || mypasscode != "") {
                            final storage = new FlutterSecureStorage();
                            await storage.write(
                                key: "PasscodeStatus", value: "true");
                            await storage.write(
                                key: "Passcode", value: "$mypasscode");
                            print("done");
                            MyToast().mytoast("Passcode Enabled");
                            Navigator.pop(context);
                          }

                          print("not");
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
