class ChatModel {
  String msg;
  String sendername;
  String time;
  String type;
  String imageurl;
  int timestamp;

  ChatModel({this.msg, this.sendername, this.time, this.timestamp, this.imageurl, this.type});

  ChatModel.fromMap(Map snapshot, String id)
      : msg = snapshot["Message"] ?? '',
        time = snapshot["Time"] ?? '',
        type = snapshot["Type"] ?? "",
        imageurl = snapshot["Image-URL"] ?? "",
        timestamp = snapshot["Time-Stamp"] ?? '',
        sendername = snapshot['Sender-Name'] ?? '';

  toJSON() {
    return {
      "Message": msg,
      "Sender-Name": sendername,
      "Time": time,
      "Type": type,
      "Image-URL": imageurl,
      "Time-Stamp": timestamp
    };
  }
}
