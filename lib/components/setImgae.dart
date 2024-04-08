import 'package:flutter/material.dart';

Widget setImage(image) {
  // String img = "http://localhost:3000/imgs/$image";
  String img = "https://concepto.de/wp-content/uploads/2015/03/$image";
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
