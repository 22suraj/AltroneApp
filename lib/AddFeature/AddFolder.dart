import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mydrive/Helper/CustomButton.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/models/FolderModel.dart';
import 'package:mydrive/services/add_service.dart';
import 'package:provider/provider.dart';

class AddFolder extends StatefulWidget {
  @override
  _AddFolderState createState() => _AddFolderState();
}

class _AddFolderState extends State<AddFolder> {
  TextEditingController _namecontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _addFolder({FolderModel foldermodel}) async {
    setState(() {
      _isLoading = true;
    });
    AddService _providerState = Provider.of<AddService>(context, listen: false);
    try {
      if (await _providerState.CreateFolder(foldermodel.toJSON())) {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.blue.shade800,
          title: Text(
            "Folder Details",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
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
                    color: Colors.white,
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
                            "Create Folder",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.06),
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _formkey,
                          child: TextFormField(
                            controller: _namecontroller,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return "Folder name is required";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Folder Name",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.04),
                                borderSide: BorderSide(
                                  color: CustomColors().mygreencolorshade600,
                                  width: 2,
                                  // style: borderStyle,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.04),
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomButton().customButton(
                            width: width,
                            title: "Submit",
                            myroute: () {
                              if (_formkey.currentState.validate()) {
                                _formkey.currentState.save();
                                // if all are valid then go to success screen
                                FolderModel _foldermodel = FolderModel();
                                _foldermodel.folderName =
                                    _namecontroller.text.trim().toString();
                                //  _addcategorymodel.imageurl = categoryimageurl;
                                _addFolder(foldermodel: _foldermodel);

                                //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
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
        ),
      ),
    );
  }
}
