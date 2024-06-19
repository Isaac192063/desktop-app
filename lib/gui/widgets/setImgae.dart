import 'package:flutter/material.dart';

Widget setImage(String? image, double tam) {
  String img = "";
  if (image == null) {
    img =
        "https://i.pinimg.com/474x/0a/08/88/0a0888d8773cdecef58cc33d089ac5df.jpg";
  } else {
    img = "http://192.168.137.27:3000/imgs/$image";
  }
  return CircleAvatar(
    radius: tam + 1,
    backgroundColor: Colors.black,
    child: CircleAvatar(
      radius: tam,
      child: _imageUser(img, tam),
      backgroundColor: Colors.white,
    ),
  );
}

Widget _imageUser(image, double tam) {
  Key key = UniqueKey();
  return CircleAvatar(
    key: key,
    backgroundImage: NetworkImage(image),
    radius: tam,
  );
}

String directionImage(String? name) => name != null
    ? "http://localhost:3000/imgs/$name"
    : "https://i.pinimg.com/474x/0a/08/88/0a0888d8773cdecef58cc33d089ac5df.jpg";
