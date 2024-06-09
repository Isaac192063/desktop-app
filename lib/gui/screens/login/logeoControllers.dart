import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/service/user_service.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/gui/screens/navigation_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

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

    ResponseApi api = await UserService().login(email, password);

    if (api.success! == false) {
      notification(context, api.message!, "Error", InfoBarSeverity.warning);
    } else {
      Map<String, dynamic> decodeToken = Jwt.parseJwt(api.token!);

      notification(context, api.message!, "Success", InfoBarSeverity.success);

      int id = decodeToken["id"];

      ResponseApi api2 = await UserService().userById(id.toString());
      User user = User.fromJson(api2.data);

      if (!user.enabled) {
        return notification(
            context, "Usuario no habilitado", "Error", InfoBarSeverity.warning);
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationPage(user, decodeToken["rol"])));
    }
  }
}
// fernandogmail.com