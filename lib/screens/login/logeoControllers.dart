import 'package:desktop_app/api/response_api.dart';
import 'package:desktop_app/api/user_provider.dart';
import 'package:desktop_app/components/notificarion.dart';
import 'package:desktop_app/screens/navigation_page.dart';
import 'package:flutter/material.dart';

class LogeoController {
  TextEditingController userCOntroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void enviar(context) async {
    String password = passwordController.text.trim();
    String email = userCOntroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      notification(context, "ningun campo puede estar vacio");
      return;
    }

    ResponseApi api = await UserProvider().login(email, password);

    if (api.success! == false) {
      notification(context, api.message!);
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NavigationPage()));
    }
  }
}
