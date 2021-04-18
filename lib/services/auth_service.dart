import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();

  Future<bool> SignUpUser(
      {String email, String password, ScaffoldState state}) async {
    bool _success = false;
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (_userCredential.user != null) {
        String token = await _firebaseMessaging.getToken();
        _firebaseFirestore
            .collection("Users")
            .doc(_auth.currentUser.uid)
            .set({"Email-id": email, "FCM-Token": token});
        return _success = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      final snackBar = SnackBar(content: Text(e.message));
      state.showSnackBar(snackBar);
      print("yess");
    }
    return _success;
  }

  Future<bool> SignInUser(
      {String email, String password, ScaffoldState state}) async {
    bool _success = false;

    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_userCredential.user != null) {
        await storage.write(key: "LoginStatus", value: "true");
        return _success = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      final snackBar = SnackBar(content: Text(e.message));
      state.showSnackBar(snackBar);
    }
    return _success;
  }

  Future<bool> ForgetPasssword({String email, ScaffoldState state}) async {
    bool _success = false;
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        final snackBar = SnackBar(
            content: Text(
                "Password reset link is sent to your registered email-id"));
        state.showSnackBar(snackBar);
        _success = true;
      });
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      final snackBar = SnackBar(content: Text(e.message));
      state.showSnackBar(snackBar);
    }
    return _success;
  }

  Future<bool> AddMsgToChatRoom(
      Map data, ScaffoldState state, String chatroomid) async {
    bool _success = false;

    try {
      _firebaseFirestore
          .collection("Chats")
          .doc("Conversation")
          .collection(chatroomid)
          .add(data)
          .catchError((e) {
        print(e.toString());
      });

      return _success = true;
    } on FirebaseFirestore catch (e) {
      print(e.toString());
    }
    print("$_success");
    return _success;
  }

  Future<bool> UpdateProfile(Map data) async {
    bool _success = false;

    try {
      _firebaseFirestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("Info")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set(data)
          .catchError((e) {
        print(e.toString());
      });

      return _success = true;
    } on FirebaseFirestore catch (e) {
      print(e.toString());
    }
    print("$_success");
    return _success;
  }
}
