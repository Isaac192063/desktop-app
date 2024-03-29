import 'package:desktop_app/screens/navigation_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class LogeoController {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  void enviar(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NavigationPage()));
  }
}
