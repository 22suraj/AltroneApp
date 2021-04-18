import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/Helper/CustomLeadingIcon.dart';
import 'package:mydrive/SharedFeature/SharedAllPhotos.dart';
import 'package:mydrive/SharedFeature/SharedPeopleDashboard.dart';
import 'package:mydrive/models/ChatModel.dart';
import 'package:mydrive/services/auth_service.dart';
import 'package:provider/provider.dart';

class SharedChatScreen extends StatefulWidget {
  String email;
  String token;
  SharedChatScreen(this.email, this.token);
  @override
  _SharedChatScreenState createState() =>
      _SharedChatScreenState(this.email, this.token);
}

class _SharedChatScreenState extends State<SharedChatScreen> {
  String email;
  String token;
  String chatRoomId;
  bool _isLoading = false;
  List<ChatModel> chatmodellist;
  TextEditingController _msgcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _SharedChatScreenState(this.email, this.token);

  createChatroomId({String currentuser, String recevier}) {
    if (currentuser.hashCode > recevier.hashCode) {
      return "$recevier\_$currentuser";
    } else {
      return "$currentuser\_$recevier";
    }
  }

  Future<void> _addMsgToChat(
      {ChatModel chatModel,
      ScaffoldState state,
      String token,
      String msg}) async {
    setState(() {
      _isLoading = true;
    });
    AuthServices _providerState =
        Provider.of<AuthServices>(context, listen: false);
    try {
      if (await _providerState.AddMsgToChatRoom(
          chatModel.toJSON(), state, chatRoomId)) {
        print("done");
        /*   final snackBar = SnackBar(content: Text("Item added to the favourite"));
        Scaffold.of(context).showSnackBar(snackBar);*/
        final postUrl = 'https://fcm.googleapis.com/fcm/send';

        final data = {
          "notification": {
            "body": "${msg}",
            "title": "${FirebaseAuth.instance.currentUser.email}",
          },
          "priority": "high",
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "id": "1",
            "status": "done",
            "sound": 'default',
            "screen": "orders",
          },
          "to": "${token}"
        };

        final headers = {
          'content-type': 'application/json',
          'Authorization':
              'key=AAAAof8EYSM:APA91bErF0XMBb0y4nbiVkgj68t8nchgyF6HQiZUAx8vEQh6pO4Zkm3-muNEWsEdQ2V4D5F4BoLSAZq2ObjOwHLvz_WZ8S8EDBKJC2dYG3s83gMdldXaVvC6qsPi16_Drcwl_FJzZQXm'
        };

        final response = await http.post(Uri.parse(postUrl),
            body: json.encode(data),
            encoding: Encoding.getByName('utf-8'),
            headers: headers);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String constructFCMPayload(String token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': '1',
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification was created via FCM!',
      },
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    chatRoomId = createChatroomId(
        currentuser: FirebaseAuth.instance.currentUser.email, recevier: email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.blue.shade800,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SharedPeopleDashboard()));
          },
          child: Text(
            "$email",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SharedAllPhotos()));
            },
            child: Center(
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Text("All Photos"),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Chats")
                    .doc("Conversation")
                    .collection(chatRoomId)
                    .orderBy("Time-Stamp", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    chatmodellist = snapshot.data.docs
                        .map((doc) =>
                            ChatModel.fromMap(doc.data(), "Banner-Info"))
                        .toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      //  physics: NeverScrollableScrollPhysics(),
                      itemCount: chatmodellist.length,
                      itemBuilder: (context, index) {
                        return chatmodellist[index].type == "text"
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                alignment:
                                    chatmodellist[index].sendername == email
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: chatmodellist[index]
                                                  .sendername !=
                                              email
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                      color: chatmodellist[index].sendername !=
                                              email
                                          ? Colors.blue.shade100
                                          : Colors.orange.shade100),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        chatmodellist[index].msg,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        chatmodellist[index].time,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 9, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                alignment:
                                    chatmodellist[index].sendername == email
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: chatmodellist[index]
                                                  .sendername !=
                                              email
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                      color: chatmodellist[index].sendername !=
                                              email
                                          ? Colors.blue.shade100
                                          : Colors.orange.shade100),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/newloading.gif',
                                          image: chatmodellist[index] != null
                                              ? "${chatmodellist[index].imageurl}"
                                              : "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg",
                                          fit: BoxFit.contain,
                                          height: 220.0,
                                        ),
                                      ),
                                      Text(
                                        chatmodellist[index].msg,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        chatmodellist[index].time,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 9, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustomColors().mygreencolorshade600),
                      ),
                    );
                  }
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Card(
                elevation: 10,
                child: TextFormField(
                  controller: _msgcontroller,
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Message is required";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Say Something",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.01),
                      borderSide: BorderSide(
                        color: CustomColors().mygreencolorshade600,
                        width: 2,
                        // style: borderStyle,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.01),
                      borderSide: BorderSide(
                        color: CustomColors().mygreencolorshade600,
                        width: 2,
                        // style: borderStyle,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // if all are valid then go to success screen
                          // KeyboardUtil.hideKeyboard(context);
                          ChatModel _chatmodel = ChatModel();
                          _chatmodel.msg =
                              _msgcontroller.text.trim().toString();
                          _chatmodel.sendername =
                              FirebaseAuth.instance.currentUser.email;
                          _chatmodel.time =
                              DateFormat().add_jm().format(DateTime.now());
                          _chatmodel.timestamp =
                              DateTime.now().millisecondsSinceEpoch;
                          _chatmodel.type = "text";
                          _addMsgToChat(
                              chatModel: _chatmodel,
                              token: token,
                              msg: _msgcontroller.text.trim().toString());
                          _msgcontroller.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: CustomColors().mygreencolorshade600,
                      ),
                    ),
                    /*   prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_a_photo,
                        color: CustomColors().mygreencolorshade600,
                      ),
                    ),*/
                  ),
                ),
              ),
            ),
          ],
        ),
      ), /*SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: CustomLeadingIcon()
                            .customLeadingIcon(icon: Icons.image, width: width),
                        title: Text(
                          "Message-1",
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      ListTile(
                        leading: CustomLeadingIcon()
                            .customLeadingIcon(icon: Icons.image, width: width),
                        title: Text(
                          "Message-2",
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      ListTile(
                        leading: CustomLeadingIcon()
                            .customLeadingIcon(icon: Icons.image, width: width),
                        title: Text(
                          "Message-3",
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      ListTile(
                        leading: CustomLeadingIcon()
                            .customLeadingIcon(icon: Icons.image, width: width),
                        title: Text(
                          "Message-4",
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: TextFormField(
                key: _formKey,
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Message is required";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Say Something",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.01),
                      borderSide: BorderSide(
                        color: CustomColors().mygreencolorshade600,
                        width: 2,
                        // style: borderStyle,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.01),
                      borderSide: BorderSide(
                        color: CustomColors().mygreencolorshade600,
                        width: 2,
                        // style: borderStyle,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                            if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        // if all are valid then go to success screen
                        // KeyboardUtil.hideKeyboard(context);
                        ChatModel _chatmodel = ChatModel();
                        _chatmodel.msg = _msgcontroller.text.trim().toString();
                        _chatmodel.sendername =
                            FirebaseAuth.instance.currentUser.email;
                        _chatmodel.time =
                            DateFormat().add_jm().format(DateTime.now());
                        _chatmodel.timestamp =
                            DateTime.now().millisecondsSinceEpoch;
                        _chatmodel.type = "text";
                        _addMsgToChat(
                          chatModel: _chatmodel,
                        );
                        _msgcontroller.clear();
                      }
                      },
                      icon: Icon(
                        Icons.send,
                        color: CustomColors().mygreencolorshade600,
                      ),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_a_photo,
                        color: CustomColors().mygreencolorshade600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )*/
    );
  }
}
