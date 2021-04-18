import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';
//import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class RecentScreen extends StatefulWidget {
  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  static String collectionDbName = 'mydrive_stories';

  //TODO: add possibility get data from any API
  CollectionReference dbInstance =
      FirebaseFirestore.instance.collection(collectionDbName);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterInstagramStories(
              collectionDbName: collectionDbName,
              showTitleOnIcon: true,
              backFromStories: () {
                print("object");
                // _backFromStoriesAlert();
              },
              iconTextStyle: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).primaryColor,
              ),
              iconImageBorderRadius: BorderRadius.circular(15.0),
              iconBoxDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff333333),
                    blurRadius: 10.0,
                    offset: Offset(
                      0.0,
                      4.0,
                    ),
                  ),
                ],
              ),
              iconWidth: 90.0,
              iconHeight: 90.0,
              textInIconPadding:
                  EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
              //how long story lasts in seconds
              imageStoryDuration: 7,
              progressPosition: ProgressPosition.top,
              repeat: true,
              inline: false,
              languageCode: 'en',
              backgroundColorBetweenStories: Colors.black,
              closeButtonIcon: Icon(
                Icons.close,
                color: Colors.white,
                size: 28.0,
              ),
              closeButtonBackgroundColor: Color(0x11000000),
              sortingOrderDesc: true,
              lastIconHighlight: true,
              lastIconHighlightColor: Colors.blue,
              //  lastIconHighlightRadius: const Radius.circular(15.0),
              captionTextStyle: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
              captionMargin: EdgeInsets.only(
                bottom: 50,
              ),
              captionPadding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
            ),
            /* Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: width * 0.05),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            height: width * 0.2,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3, color: Colors.grey.shade400),
                              image: DecorationImage(
                                image: AssetImage("assets/llogo.png"),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                              color: CustomColors().mygreencolorshade600,
                            ),
                          ),
                          Container(
                            child: Text(
                              "2 Years\nago",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                              height: width * 0.2,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3, color: Colors.grey.shade400),
                                image: DecorationImage(
                                  image: AssetImage("assets/llogo.png"),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                                color: CustomColors().mygreencolorshade600,
                              )),
                          Container(
                            child: Text(
                              "3 Years\nago",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),*/
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
                                        image: AssetImage("assets/llogo.png"))),
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
    );
  }

  _backFromStoriesAlert() {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(
          "User have looked stories and closed them.",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: Text("Dismiss"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
