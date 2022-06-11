import 'dart:convert';

class MyUser {
  static const String collectionName = "my user";
  String id;
  String fname;
  String lname;
  String username;
  String email;
  MyUser(
      {required this.id,
      required this.fname,
      required this.lname,
      required this.username,
      required this.email});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"] as String,
          fname: json["fname"] as String,
          lname: json["lname"] as String,
          username: json["username"] as String,
          email: json["email"] as String,
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fname": fname,
      "lname": lname,
      "username": username,
      "email": email,
    };
  }
}
