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
  int idEmployee;
  String name;
  String lastName;
  String phoneNumber;
  DateTime initialData;
  String email;
  String password;
  String image;

  User({
    required this.idEmployee,
    required this.name,
    required this.lastName,
    required this.phoneNumber,
    required this.initialData,
    required this.email,
    required this.password,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idEmployee: json["id_user"],
        name: json["name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        initialData: DateTime.parse(json["initial_data"]),
        email: json["email"],
        password: json["password"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id_employee": idEmployee,
        "name": name,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "initial_data": initialData.toIso8601String(),
        "email": email,
        "password": password,
        "image": image,
      };
}
