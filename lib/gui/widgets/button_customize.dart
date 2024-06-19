import 'package:fluent_ui/fluent_ui.dart';

Widget buttonCustomize(
    {context,
    required String text,
    required execute,
    required Color color,
    double pad = 8}) {
  return FilledButton(
      child: Text(text),
      onPressed: () {
        execute();
      },
      style: ButtonStyle(
          backgroundColor: ButtonState.all(color),
          padding: ButtonState.all(
              EdgeInsets.symmetric(horizontal: pad, vertical: 8)),
          textStyle: ButtonState.all(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))));
}

Widget buttonCustomizeProduct(
    {context, required String text, required execute, required Color color}) {
  return FilledButton(
      child: Text(text),
      onPressed: () {
        execute();
      },
      style: ButtonStyle(
          backgroundColor: ButtonState.all(color),
          padding: ButtonState.all(
              EdgeInsets.symmetric(vertical: 7, horizontal: 80)),
          textStyle: ButtonState.all(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))));
}
