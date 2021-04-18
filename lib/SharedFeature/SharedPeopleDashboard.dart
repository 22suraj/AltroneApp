import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';

class SharedPeopleDashboard extends StatefulWidget {
  @override
  _SharedPeopleDashboardState createState() => _SharedPeopleDashboardState();
}

class _SharedPeopleDashboardState extends State<SharedPeopleDashboard> {
  @override
  Widget build(BuildContext context) {
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
                                "    People",
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
                        ListTile(
                          leading: CustomLeadingIcon().customLeadingIcon(
                              icon: Icons.image, width: width),
                          title: Text(
                            "ABC-XYZ",
                            style: GoogleFonts.lato(),
                          ),
                          trailing: Text(
                            "Leave",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ListTile(
                            leading: CustomLeadingIcon().customLeadingIcon(
                                icon: Icons.image, width: width),
                            title: Text(
                              "DEF-PQR",
                              style: GoogleFonts.lato(),
                            ),
                            trailing: DropdownButton<String>(
                              icon: Icon(Icons.more_vert_rounded),
                              underline: Text(""),
                              items: [
                                DropdownMenuItem<String>(
                                  value: "",
                                  child: new Text("Block Person"),
                                )
                              ],
                              onChanged: (_) {},
                            )),
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
