import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/FilesFeature/PhotoScreen.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';

class FileDashboard extends StatefulWidget {
  @override
  _FileDashboardState createState() => _FileDashboardState();
}

class _FileDashboardState extends State<FileDashboard> {
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
                        "Files",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.06),
                        ),
                      ),
                    ),
                    Divider(),
                    GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 1.5,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children: [
                          Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLeadingIcon().customLeadingIcon(
                                    width: width, icon: Icons.note),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Document",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoScreen()));
                            },
                            child: Card(
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomLeadingIcon().customLeadingIcon(
                                      width: width, icon: Icons.photo),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Photo",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLeadingIcon().customLeadingIcon(
                                    width: width, icon: Icons.video_collection),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Video",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLeadingIcon().customLeadingIcon(
                                    width: width, icon: Icons.file_copy),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Others",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10,
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
