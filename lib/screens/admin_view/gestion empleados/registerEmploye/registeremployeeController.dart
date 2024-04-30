import 'dart:io';
import 'package:desktop_app/api/environment.dart';
import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/api/response_api.dart';
import 'package:desktop_app/widgets/notification.dart';
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
  User? user;
  String? description;

  RegisterEmployeeController({this.user});

  void init(BuildContext context) {
    this.context = context;
    if (user != null) {
      nameController.text = user!.name;
      lastNameController.text = user!.lastName;
      emailController.text = user!.email;
      numberPhoneController.text = user!.phoneNumber;
    }
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
    dynamic res;
    try {
      if (user == null) {
        res = await dio.post("${Environment.API_RDQ}/user", data: formData);
      } else {
        res = await dio.put("${Environment.API_RDQ}/user/${user?.idEmployee}",
            data: formData);
      }

      Map<String, dynamic> json = res.data.cast<String, dynamic>();
      ResponseApi responseApi = ResponseApi.fromJson(json);

      if (responseApi.success!) {
        return notification(
          context!,
          responseApi.message!,
          "sucess",
          InfoBarSeverity.success,
        );
      }

      notification(
          context!, responseApi.message!, "alerta", InfoBarSeverity.warning);
    } catch (e) {
      notification(context!, "Error al registrar al empleado", "error",
          InfoBarSeverity.error);
    }
  }
}
