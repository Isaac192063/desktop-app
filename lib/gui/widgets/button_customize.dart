import 'package:fluent_ui/fluent_ui.dart';

Widget buttonCustomize(
    {context, required String text, required execute, required Color color}) {
  return FilledButton(
      child: Text(text),
      onPressed: () {
        execute();
      },
      style: ButtonStyle(
          backgroundColor: ButtonState.all(color),
          padding: ButtonState.all(EdgeInsets.all(8)),
          textStyle: ButtonState.all(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))));
}
