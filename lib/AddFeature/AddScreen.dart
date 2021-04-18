import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydrive/AddFeature/AddFolder.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photofilters/photofilters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  static String collectionDbName = 'mydrive_stories';
  CollectionReference dbInstance =
      FirebaseFirestore.instance.collection(collectionDbName);

  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;
  List<File> images = [];
  final picker = ImagePicker();

  Future getImageandupload(context, source) async {
    // ignore: deprecated_member_us
    await picker
        .getImage(source: source, imageQuality: 50)
        .then((imageFile) async {
      if (imageFile != null) {
        File cropped = await ImageCropper.cropImage(
            sourcePath: imageFile.path,
            compressQuality: 100,
            compressFormat: ImageCompressFormat.jpg,
            androidUiSettings: AndroidUiSettings(
              lockAspectRatio: false,
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              toolbarTitle: "Crop Image",
              statusBarColor: Colors.blue,
              backgroundColor: Theme.of(context).primaryColor,
            ));
        fileName = basename(cropped.path);
        var image = imageLib.decodeImage(cropped.readAsBytesSync());
        image = imageLib.copyResize(image, width: 600);
        Map imagefile = await Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new PhotoFilterSelector(
              appBarColor: Colors.blue,
              title: Text(
                "Photo Filters",
                // style: MyStyle().mymcLarenfontstyle,
              ),
              image: image,
              filters: presetFiltersList,
              filename: fileName,
              loader: Center(child: CircularProgressIndicator()),
              fit: BoxFit.contain,
            ),
          ),
        );
        if (imagefile != null && imagefile.containsKey('image_filtered')) {
          setState(() {
            imageFile = imagefile['image_filtered'];
            // images.add(imageFile);
          });
          print(imageFile.path);
        }
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  void _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                color: Colors.white,
              ),
              iconImageBorderRadius: BorderRadius.circular(15.0),
              iconBoxDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Color(0xFFffffff),
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
            /*Container(
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
                      //  margin: EdgeInsets.symmetric(vertical: width * 0.1),
                      child: Text(
                        "Menu",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.06),
                        ),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        getImageandupload(context, ImageSource.gallery);
                      },
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          leading: CustomLeadingIcon().customLeadingIcon(
                              icon: Icons.cloud_upload, width: width),
                          title: Text(
                            "Upload",
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CustomLeadingIcon().customLeadingIcon(
                            icon: Icons.scanner_rounded, width: width),
                        title: Text(
                          "Scan a photo",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getImageandupload(context, ImageSource.camera);
                      },
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          leading: CustomLeadingIcon().customLeadingIcon(
                              icon: Icons.camera_alt, width: width),
                          title: Text(
                            "Take a photo",
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddFolder()));
                      },
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          leading: CustomLeadingIcon().customLeadingIcon(
                              icon: Icons.create_new_folder, width: width),
                          title: Text(
                            "Create Folder",
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
