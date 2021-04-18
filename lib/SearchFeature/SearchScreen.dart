import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchcontroller = TextEditingController();

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
                        "Search",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.06),
                        ),
                      ),
                    ),
                    Divider(),
                    TextFormField(
                      controller: _searchcontroller,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Search field is Empty";
                        }
                      },
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: "Search Box",
                        hintStyle: GoogleFonts.lato(),
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
                        suffixIcon: Icon(
                          Icons.search,
                          color: CustomColors().mygreencolorshade600,
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "People",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "View all",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade100,
                              image: DecorationImage(
                                  image: AssetImage("assets/llogo.png"))),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade100,
                              image: DecorationImage(
                                  image: AssetImage("assets/llogo.png"))),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade100,
                              image: DecorationImage(
                                  image: AssetImage("assets/llogo.png"))),
                        ),
                      ],
                    ),
                    Divider(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Place",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "View all",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Things",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "View all",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
}
