import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mydrive/Helper/CustomButton.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _ishidden = true;
  bool _isLoading = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      AuthServices _authservice = AuthServices();

      if (_authservice.SignUpUser(
              email: _emailcontroller.text.trim().toString(),
              password: _passwordcontroller.text.trim().toString()) !=
          null) {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
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
                    radius: MediaQuery.of(context).size.width * 0.2,
                    backgroundImage: AssetImage("assets/llogo.png"),
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
                      "Registration",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.08),
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
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            /* TextFormField(
                              controller: _fullnamecontroller,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Full Name is required";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Full Name",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.account_circle_rounded,
                                  color: CustomColors().mygreencolorshade600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),*/
                            TextFormField(
                              controller: _emailcontroller,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Email Address is required";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Email Address",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: CustomColors().mygreencolorshade600,
                                ),
                              ),
                            ),
                            /* SizedBox(
                              height: 15,
                            ),
                             Row(
                              children: [
                                CountryCodePicker(
                                  onChanged: print,
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'US',
                                  favorite: ['+1'],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: true,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: false,
                                  // optional. aligns the flag and the Text left
                                  alignLeft: false,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _mobilenocontroller,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return "Mobile Number is required";
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Mobile Number",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.04),
                                        borderSide: BorderSide(
                                          color: CustomColors()
                                              .mygreencolorshade600,
                                          width: 2,
                                          // style: borderStyle,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.04),
                                        borderSide: BorderSide(
                                          color: CustomColors()
                                              .mygreencolorshade600,
                                          width: 2,
                                          // style: borderStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),*/
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _passwordcontroller,
                              obscureText: _ishidden ? true : false,
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Password is required";
                                }
                              },
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: CustomColors().mygreencolorshade600,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _ishidden = !_ishidden;
                                    });
                                  },
                                  child: Icon(
                                    _ishidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: CustomColors().mygreencolorshade600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _confirmpasswordcontroller,
                              obscureText: _ishidden ? true : false,
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Confirm Password is required";
                                }
                                if (value != _passwordcontroller.text) {
                                  return "Password did't match";
                                }
                              },
                              style: TextStyle(
                                  color:Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  borderSide: BorderSide(
                                    color: CustomColors().mygreencolorshade600,
                                    width: 2,
                                    // style: borderStyle,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: CustomColors().mygreencolorshade600,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _ishidden = !_ishidden;
                                    });
                                  },
                                  child: Icon(
                                    _ishidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: CustomColors().mygreencolorshade600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomButton().customButton(
                                width: width,
                                title: "Submit",
                                myroute: () {
                                  if (!_formkey.currentState.validate()) {
                                    return;
                                  }
                                  _signUp();
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                ],
              ),
            )),
      ),
    );
  }
}
