import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';
import 'package:mydrive/SharedFeature/SharedChatScreen.dart';
import 'package:mydrive/models/ChatUserModel.dart';

class SharedDashboard extends StatefulWidget {
  @override
  _SharedDashboardState createState() => _SharedDashboardState();
}

class _SharedDashboardState extends State<SharedDashboard> {
  List<ChatUserModel> userlist;

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
                        "Shared",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.06),
                        ),
                      ),
                    ),
                    Divider(),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Users")
                            .where("Email-id",
                                isNotEqualTo:
                                    FirebaseAuth.instance.currentUser.email)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            userlist = snapshot.data.docs
                                .map((doc) => ChatUserModel.fromMap(doc.data()))
                                .toList();
                            return ListView.builder(
                              // padding: EdgeInsets.only(left: 20, right: 20),
                              shrinkWrap: true,

                              physics: NeverScrollableScrollPhysics(),
                              itemCount: userlist.length,
                              itemBuilder: (buildContext, index) {
                                return Card(
                                  elevation: 10,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SharedChatScreen(
                                                      userlist[index].email,
                                                      userlist[index].token)));
                                    },
                                    leading: CustomLeadingIcon()
                                        .customLeadingIcon(
                                            icon: Icons.image, width: width),
                                    title: Text(
                                      "${userlist[index].email}",
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(Icons.cancel),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ));
                          }
                        }),
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
