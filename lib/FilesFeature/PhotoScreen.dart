import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
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
                          child: Text(
                            "Photo",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.06),
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          child: Text(
                            "Wednesday, 24 July 2019",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-1",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-2",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-3",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Container(
                          child: Text(
                            "Tuesday, 23 July 2019",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-1",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-2",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-3",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Container(
                          child: Text(
                            "Monday, 22 July 2019",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-1",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-2",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  color: Colors.blue.shade100,
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/llogo.png"))),
                                  ),
                                ),
                                Text(
                                  "Image-3",
                                  style: GoogleFonts.lato(fontSize: 12),
                                )
                              ],
                            ),
                          ],
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
