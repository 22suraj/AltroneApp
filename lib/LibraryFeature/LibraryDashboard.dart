import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';
import 'package:mydrive/models/FolderModel.dart';
import 'package:mydrive/services/add_service.dart';
import 'package:provider/provider.dart';

class LibraryDashboard extends StatefulWidget {
  @override
  _LibraryDashboardState createState() => _LibraryDashboardState();
}

class _LibraryDashboardState extends State<LibraryDashboard> {
  List<FolderModel> folderlist = [];
  TextEditingController _namecontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  showAlertDialog(BuildContext context, String name, AddService folderProvider,
      String id, var width) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget renameButton = FlatButton(
      child: Text("Rename"),
      onPressed: () {
        if (_formkey.currentState.validate()) {
          _formkey.currentState.save();
          folderProvider.renmaeFolder(
              id, _namecontroller.text.trim().toString());
          _namecontroller.clear();
          Navigator.pop(context);
        }
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        folderProvider.deleteFolder(id);
        Navigator.pop(context);
      },
    );

    Widget textfield = Form(
      key: _formkey,
      child: TextFormField(
        controller: _namecontroller,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value.trim().isEmpty) {
            return "Folder name is required";
          }
        },
        decoration: InputDecoration(
          hintText: "Enter Folder Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.04),
            borderSide: BorderSide(
              color: CustomColors().mygreencolorshade600,
              width: 2,
              // style: borderStyle,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.04),
            borderSide: BorderSide(
              color: CustomColors().mygreencolorshade600,
              width: 2,
              // style: borderStyle,
            ),
          ),
          prefixIcon: Icon(
            Icons.folder,
            color: CustomColors().mygreencolorshade600,
          ),
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Folder Alert"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Would you like to delete/rename the ${name} folder ?"),
          SizedBox(
            height: 15,
          ),
          textfield
        ],
      ),
      actions: [
        cancelButton,
        renameButton,
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
    final addProvider = Provider.of<AddService>(context);
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
                        "Library",
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
                                    width: width, icon: Icons.favorite),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Favourites",
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
                                    width: width, icon: Icons.archive),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Archive",
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
                                    width: width, icon: Icons.delete),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Trash",
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
                                    width: width, icon: Icons.photo_album),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Albums",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                    Divider(),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Folder")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            folderlist = snapshot.data.docs
                                .map((doc) =>
                                    FolderModel.fromMap(doc.data(), doc.id))
                                .toList();
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              itemCount: folderlist.length,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onLongPress: () {},
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        child: Card(
                                          elevation: 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.folder,
                                                color: Colors.grey,
                                                size: width * 0.2,
                                              ),
                                              Text(
                                                "${folderlist[index].folderName}",
                                                style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                folderlist[index].folderName,
                                                addProvider,
                                                folderlist[index].id,
                                                width);
                                          }),
                                    ],
                                  ),
                                );
                              },
                            );

                            /*GridView.count(
                                shrinkWrap: true,
                                childAspectRatio: 1,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: [
                                  Card(
                                    elevation: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder,
                                          color: Colors.grey,
                                          size: width * 0.2,
                                        ),
                                        Text(
                                          "Folder-1",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder,
                                          size: width * 0.2,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "Folder-2",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder,
                                          size: width * 0.2,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "Folder-3",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder,
                                          size: width * 0.2,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "Folder-4",
                                          style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]);*/
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ));
                          }
                        }),
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
