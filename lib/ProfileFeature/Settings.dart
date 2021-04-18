import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';
import 'package:mydrive/SharedFeature/dark_theme_provider.dart';
import 'package:mydrive/passcode.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    print(themeChange.darkTheme);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "    Settings",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.06),
                                ),
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
                            leading: CustomLeadingIcon().customLeadingIcon(
                                icon: Icons.settings_backup_restore,
                                width: width),
                            title: Text(
                              "BackUp and Sync",
                              style: GoogleFonts.lato(),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          child: ListTile(
                            leading: CustomLeadingIcon().customLeadingIcon(
                                icon: Icons.nightlight_round, width: width),
                            trailing: CustomSwitch(
                              activeColor: Colors.blueAccent,
                              value: themeChange.darkTheme,
                              onChanged: (value) {
                                setState(() {
                                  themeChange.darkTheme = value;
                                });
                              },
                            ),
                            title: Text(
                              "Dark Mode",
                              style: GoogleFonts.lato(),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          child: ListTile(
                            leading: CustomLeadingIcon().customLeadingIcon(
                                icon: Icons.notifications, width: width),
                            title: Text(
                              "Notifications",
                              style: GoogleFonts.lato(),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          child: ListTile(
                            leading: CustomLeadingIcon().customLeadingIcon(
                                icon: Icons.group, width: width),
                            title: Text(
                              "Memories",
                              style: GoogleFonts.lato(),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PasscodeScreen()));
                          },
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              leading: CustomLeadingIcon().customLeadingIcon(
                                  icon: Icons.code, width: width),
                              title: Text(
                                "Set Passcode",
                                style: GoogleFonts.lato(),
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
        ),
      ),
    );
  }
}
