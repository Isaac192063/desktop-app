import 'package:desktop_app/api/response_api.dart';
import 'package:desktop_app/api/user_provider.dart';
import 'package:desktop_app/components/notification.dart';
import 'package:desktop_app/screens/navigation_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class LogeoController {
  TextEditingController userCOntroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void enviar(context) async {
    String password = passwordController.text.trim();
    String email = userCOntroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      notification(context, "ningun campo puede estar vacio", "Error",
          InfoBarSeverity.warning);
      return;
    }

    ResponseApi api = await UserProvider().login(email, password);

    if (api.success! == false) {
      notification(context, api.message!, "Error", InfoBarSeverity.warning);
    } else {
      notification(context, api.message!, "Success", InfoBarSeverity.success);

      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NavigationPage()));
      });
    }
  }
}
