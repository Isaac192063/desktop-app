import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/api/response_api.dart';
import 'package:desktop_app/api/user_provider.dart';
import 'package:desktop_app/components/notification.dart';
import 'package:desktop_app/screens/admin_view/navigation_page_admin.dart';
import 'package:desktop_app/screens/navigation_page.dart';
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

    ResponseApi api = await UserProvider().login(email, password);

    if (api.success! == false) {
      notification(context, api.message!, "Error", InfoBarSeverity.warning);
    } else {
      Map<String, dynamic> decodeToken = Jwt.parseJwt(api.token!);

      notification(context, api.message!, "Success", InfoBarSeverity.success);
      int id = decodeToken["id"];

      ResponseApi api2 = await UserProvider().userById(id.toString());
      User user = User.fromJson(api2.data);

      if (decodeToken["rol"] == "user") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigationPage(user)));
      } else if (decodeToken["rol"] == "admin") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigationPageAdmin(user)));
      }
    }
  }
}
