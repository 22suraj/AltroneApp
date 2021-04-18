import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mydrive/Helper/CustomButton.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/services/auth_service.dart';

class ForgetScreen extends StatefulWidget {
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailcontroller = TextEditingController();
  bool _isLoading = false;

  Future<void> _forgetPassword(ScaffoldState state) async {
    setState(() {
      _isLoading = true;
    });

    try {
      AuthServices _authservice = AuthServices();

      if (_authservice.ForgetPasssword(
              email: _emailcontroller.text.trim().toString(), state: state) !=
          null) {}
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
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
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
                    "Forget Password",
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
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailcontroller,
                            style: TextStyle(
                                color: Colors.black,
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
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton().customButton(
                              width: width,
                              title: "Continue",
                              myroute: () {
                                if (!_formkey.currentState.validate()) {
                                  return;
                                }
                                _forgetPassword(_scaffoldKey.currentState);
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
          ),
        ),
      ),
    );
  }
}
