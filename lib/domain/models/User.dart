// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

List<User> convertToUserList(List<dynamic> userList) {
  return userList.map((userData) => User.fromJson(userData)).toList();
}

class User {
  int id;
  String name;
  String lastName;
  String phoneNumber;
  DateTime initialData;
  String email;
  String password;
  String? image;
  bool enabled;

  User(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.phoneNumber,
      required this.initialData,
      required this.email,
      required this.password,
      this.image,
      required this.enabled});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      lastName: json["last_name"],
      phoneNumber: json["phone_number"],
      initialData: DateTime.parse(json["initial_data"]),
      email: json["email"],
      password: json["password"],
      image: json["image"],
      enabled: json["enabled"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "initial_data": initialData.toIso8601String(),
        "email": email,
        "password": password,
        "image": image,
        "enabled": enabled
      };
}
