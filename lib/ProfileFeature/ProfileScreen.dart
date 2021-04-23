import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';
import 'package:mydrive/LoginAndRegister/LoginScreen.dart';
import 'package:mydrive/ProfileFeature/Settings.dart';
import 'package:mydrive/ProfileFeature/UserInfo.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
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
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [CustomColors().mygreenboxshadow],
              ),
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: width * 0.05),
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Container(
                      //  margin: EdgeInsets.symmetric(vertical: width * 0.1),
                      child: Text(
                        "Account",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.06),
                        ),
                      ),
                    ),
                    Divider(),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/llogo.png",
                      ),
                      radius: width * 0.15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            "My Drive",
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "mydrive@gmail.com",
                            style: GoogleFonts.lato(),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserInfo()));
                        },
                        leading: CustomLeadingIcon().customLeadingIcon(
                            icon: Icons.account_box_outlined, width: width),
                        title: Text(
                          "User Info",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CustomLeadingIcon()
                            .customLeadingIcon(icon: Icons.cloud, width: width),
                        title: Text(
                          "Account Storage",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                        leading: CustomLeadingIcon().customLeadingIcon(
                            icon: Icons.settings, width: width),
                        title: Text(
                          "Settings",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CustomLeadingIcon().customLeadingIcon(
                            icon: Icons.question_answer, width: width),
                        title: Text(
                          "Help and Feedback",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CustomLeadingIcon().customLeadingIcon(
                            icon: Icons.privacy_tip, width: width),
                        title: Text(
                          "Privacy and Policy",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CustomLeadingIcon()
                            .customLeadingIcon(icon: Icons.info, width: width),
                        title: Text(
                          "Terms and Conditions",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final storage = new FlutterSecureStorage();
                        await storage
                            .write(key: "LoginStatus", value: "false")
                            .then((value) {
                          storage.write(key: "PasscodeStatus", value: "false");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        });
                      },
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          leading: CustomLeadingIcon().customLeadingIcon(
                              icon: Icons.logout, width: width),
                          title: Text(
                            "Logout",
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
