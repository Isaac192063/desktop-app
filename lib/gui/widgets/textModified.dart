import 'package:fluent_ui/fluent_ui.dart';

Widget textModified(String text, double size,
    {Color? color, bool? bold = false}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size,
        fontWeight: bold! ? FontWeight.bold : FontWeight.w400,
        color: color),
  );
}
