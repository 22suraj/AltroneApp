import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';
import 'package:mydrive/models/ChatUserModel.dart';
import 'package:mydrive/services/auth_service.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _isLoading = false;
  TextEditingController _firstnamecontroller = TextEditingController();
  TextEditingController _lastnamecontroller = TextEditingController();
  TextEditingController _dobcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<ChatUserModel> chatuserlist;

  Future<void> _updateProfile({ChatUserModel usermodel}) async {
    setState(() {
      _isLoading = true;
    });
    AuthServices _providerState =
        Provider.of<AuthServices>(context, listen: false);
    try {
      if (await _providerState.UpdateProfile(usermodel.toJSON())) {
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

  showAlertDialog(
      BuildContext context, String name, AuthServices authProvider, var width) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Save",
        style: TextStyle(),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          // if all are valid then go to success screen
          // KeyboardUtil.hideKeyboard(context);
          ChatUserModel _usermodel = ChatUserModel();
          _usermodel.firstName = _firstnamecontroller.text.trim().toString();
          _usermodel.lastName = _lastnamecontroller.text.trim().toString();
          _usermodel.dob = _dobcontroller.text.trim().toString();
          _updateProfile(usermodel: _usermodel);
          _firstnamecontroller.clear();
          _lastnamecontroller.clear();
          _dobcontroller.clear();
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Profile"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstnamecontroller,
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "First Name is required";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.01),
                        borderSide: BorderSide(
                          color: CustomColors().mygreencolorshade600,
                          width: 2,
                          // style: borderStyle,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.01),
                        borderSide: BorderSide(
                          color: CustomColors().mygreencolorshade600,
                          width: 2,
                          // style: borderStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastnamecontroller,
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Last Name is required";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.01),
                        borderSide: BorderSide(
                          color: CustomColors().mygreencolorshade600,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.01),
                        borderSide: BorderSide(
                          color: CustomColors().mygreencolorshade600,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimeField(
                    controller: _dobcontroller,
                    validator: (value) {
                      if (value == null) {
                        return "dob is required";
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Select Date",
                      labelText: "Date of Birth",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.01),
                        borderSide: BorderSide(
                          color: CustomColors().mygreencolorshade600,
                          width: 2,
                          // style: borderStyle,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.01),
                        borderSide: BorderSide(
                          color: CustomColors().mygreencolorshade600,
                          width: 2,
                          // style: borderStyle,
                        ),
                      ),
                    ),
                    format: DateFormat("dd-MM-yyyy"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomColors().mygreencolorshade600,
                                  onPrimary: Colors.white,
                                  surface: CustomColors().mygreencolorshade600,
                                ),
                                dialogBackgroundColor: Colors.white),
                            child: child,
                          );
                        },
                      );
                      if (date != null) {
                        return date;
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthServices>(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection("Info")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          chatuserlist = snapshot.data.docs
                              .map((doc) => ChatUserModel.fromMap(doc.data()))
                              .toList();
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [CustomColors().mygreenboxshadow],
                            ),
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: width * 0.05),
                              child: Column(
                                children: <Widget>[
                                  Divider(),
                                  Container(
                                    //  margin: EdgeInsets.symmetric(vertical: width * 0.1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "    User Info",
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: width * 0.06),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  showAlertDialog(
                                                      context,
                                                      "name",
                                                      authProvider,
                                                      width);
                                                },
                                                icon: Icon(Icons.edit))
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.cancel),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Card(
                                    elevation: 10,
                                    child: ListTile(
                                      title: Text(
                                        chatuserlist.length == 0
                                            ? "First Name : Add your Name"
                                            : "First Name : ${chatuserlist[0].firstName}",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 10,
                                    child: ListTile(
                                      title: Text(
                                        chatuserlist.length == 0
                                            ? "Last Name : Add your Name"
                                            : "Last Name : ${chatuserlist[0].lastName}",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 10,
                                    child: ListTile(
                                      title: Text(
                                        chatuserlist.length == 0
                                            ? "DOB : Add DOB"
                                            : "DOB :  ${chatuserlist[0].dob}",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.orange),
                          ));
                        }
                      }),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
