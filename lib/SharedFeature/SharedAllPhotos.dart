import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrive/Helper/CustomColors.dart';

class SharedAllPhotos extends StatefulWidget {
  @override
  _SharedAllPhotosState createState() => _SharedAllPhotosState();
}

class _SharedAllPhotosState extends State<SharedAllPhotos> {
  bool isBottom = false;

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      // reached bottom
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() => isBottom = true);
      }

      // IS SCROLLING
//         if (_controller.offset >= _controller.position.minScrollExtent &&
//             _controller.offset < _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
//           setState(() {
//             isBottom = false;
//           });
//         }

      // REACHED TOP
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() => isBottom = false);
      }
    });
  }

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
                                "    Shared Photos :",
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
                        GridView.count(
                            shrinkWrap: true,
                            controller: _controller,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            crossAxisCount: 3,
                            //    physics: NeverScrollableScrollPhysics(),
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
                                    "Image-4",
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
                                    "Image-5",
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
                                    "Image-6",
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
                                    "Image-6",
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
                                    "Image-6",
                                    style: GoogleFonts.lato(fontSize: 12),
                                  )
                                ],
                              ),
                            ]),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
