import 'dart:convert';

List<User> usersFromJson(String str) {
  List<dynamic> jsonData = json.decode(str);
  return List<User>.from(jsonData.map((user) => User.fromJson(user)));
}

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String name;
  DateTime birthdate;
  String email;
  String password;
  String imagen;
  DateTime createdAt;
  DateTime updatedAt;
  List<Publicacione> publicaciones;

  User({
    required this.id,
    required this.name,
    required this.birthdate,
    required this.email,
    required this.password,
    required this.imagen,
    required this.createdAt,
    required this.updatedAt,
    required this.publicaciones,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        birthdate: DateTime.parse(json["birthdate"]),
        email: json["email"],
        password: json["password"],
        imagen: json["imagen"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publicaciones: List<Publicacione>.from(
            json["publicaciones"].map((x) => Publicacione.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "email": email,
        "password": password,
        "imagen": imagen,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publicaciones":
            List<dynamic>.from(publicaciones.map((x) => x.toJson())),
      };
}

class Publicacione {
  int id;
  String idUser;
  String name;
  String desciption;
  DateTime createdAt;
  DateTime updatedAt;

  Publicacione({
    required this.id,
    required this.idUser,
    required this.name,
    required this.desciption,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Publicacione.fromJson(Map<String, dynamic> json) => Publicacione(
        id: json["id"],
        idUser: json["id_user"],
        name: json["name"],
        desciption: json["desciption"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "name": name,
        "desciption": desciption,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
