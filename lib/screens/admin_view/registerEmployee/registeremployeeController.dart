import 'dart:io';
import 'package:desktop_app/api/environment.dart';
import 'package:desktop_app/api/response_api.dart';
import 'package:desktop_app/components/notification.dart';
import 'package:desktop_app/config/dio.dart';
import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';

class RegisterEmployeeController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? imagen;

  void init(BuildContext context) {
    this.context = context;
  }

  Future<void> register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String numberPhone = numberPhoneController.text.trim();
    String password = passwordController.text.trim();

    FormData formData;
    if (imagen == null) {
      formData = FormData.fromMap({
        'email': email,
        'name': name,
        'last_name': lastName,
        'phone_number': numberPhone,
        'password': password,
        "rol": "1"
      });
    } else {
      String filename = imagen!.path.split('/').last;
      formData = FormData.fromMap({
        'email': email,
        'name': name,
        'last_name': lastName,
        'phone_number': numberPhone,
        'image': await MultipartFile.fromFile(imagen!.path, filename: filename),
        'password': password,
        "rol": "1"
      });
    }
    try {
      final res = await dio.post("${Environment.API_RDQ}/user", data: formData);

      Map<String, dynamic> json = res.data.cast<String, dynamic>();
      ResponseApi responseApi = ResponseApi.fromJson(json);

      if (responseApi.success!) {
        notification(
            context!, "empleado registrado", "sucess", InfoBarSeverity.success);
      } else {
        notification(context!, "empleado no registrado", "alerta",
            InfoBarSeverity.warning);
      }
    } catch (error) {
      notification(context!, "Error al registrar al empleado", "error",
          InfoBarSeverity.error);
    }
  }
}
