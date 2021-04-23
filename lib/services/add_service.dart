import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddService extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> CreateFolder(Map data) async {
    bool _success = false;
    try {
      _firestore.collection("Folder").add(data);
      return _success = true;
    } on FirebaseFirestore catch (e) {
      print(e.toString());
    }
    print("$_success");
    return _success;
  }

  deleteFolder(String id) {
    try {
      _firestore.collection("Folder").doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  renmaeFolder(String id, String newname) {
    try {
      _firestore.collection("Folder").doc(id).update({"Folder-Name": newname});
    } catch (e) {
      print(e.toString());
    }
  }
}
