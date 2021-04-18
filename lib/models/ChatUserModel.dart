class ChatUserModel {
  String email;
  String token;
  String firstName;
  String lastName;
  String dob;

  ChatUserModel(
      {this.email, this.token, this.firstName, this.lastName, this.dob});

  ChatUserModel.fromMap(Map snapshot)
      : email = snapshot["Email-id"] ?? '',
        firstName = snapshot["First-Name"] ?? '',
        lastName = snapshot["Last-Name"] ?? '',
        dob = snapshot["DOB"] ?? '',
        token = snapshot["FCM-Token"] ?? '';

  toJSON() {
    return {
      "Email-id": email,
      "FCM-Token": token,
      "First-Name": firstName,
      "Last-Name": lastName,
      "DOB": dob
    };
  }
}
