import 'package:fluent_ui/fluent_ui.dart';

Widget textModified(String text, double size, {Color? color}) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.w600, color: color),
  );
}
