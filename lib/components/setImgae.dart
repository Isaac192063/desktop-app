import 'package:desktop_app/utils/myColors.dart';
import 'package:flutter/material.dart';

Widget setImage(image) {
  String img = "http://localhost:3000/imgs/$image";
  return CircleAvatar(
    radius: 95,
    backgroundColor: Colors.black,
    child: CircleAvatar(
      radius: 90,
      child: _imageUser(img),
    ),
  );
}

Widget _imageUser(image) {
  Key key = UniqueKey();
  return CircleAvatar(
    key: key,
    backgroundImage: NetworkImage(image),
    radius: 90,
  );
}
