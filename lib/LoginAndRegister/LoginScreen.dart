import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mydrive/ForgetPassword/ForgetPasswordScreen.dart';
import 'package:mydrive/Helper/CustomButton.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/LoginAndRegister/RegisterScreen.dart';
import 'package:mydrive/LoginAndRegister/VerificationScreen.dart';
import 'package:mydrive/MainDashboard/DashboardScreen.dart';
import 'package:mydrive/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _ishidden = true;
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  Future<void> _loginUser(
      {String email, String password, ScaffoldState state}) async {
    setState(() {
      _isLoading = true;
    });
    AuthServices _providerState =
        Provider.of<AuthServices>(context, listen: false);
    try {
      if (await _providerState.SignInUser(
          email: email, password: password, state: state)) {
        FirebaseAuth auth = FirebaseAuth.instance;
        print(auth.currentUser.emailVerified);
        if (auth.currentUser.emailVerified) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else {
          auth.currentUser.sendEmailVerification();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerificationScreen(auth.currentUser.email)),
          );
        }
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
                    "Login",
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
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetScreen()));
                            },
                            child: Container(
                              child: Text(
                                "Forget Password?",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton().customButton(
                              width: width,
                              title: "Login",
                              myroute: () {
                                if (!_formkey.currentState.validate()) {
                                  return;
                                }
                                _loginUser(
                                    email:
                                        _emailcontroller.text.trim().toString(),
                                    password: _passwordcontroller.text
                                        .trim()
                                        .toString(),
                                    state: _scaffoldKey.currentState);
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          CustomButton().customButton(
                              width: width,
                              title: "Register",
                              myroute: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
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
