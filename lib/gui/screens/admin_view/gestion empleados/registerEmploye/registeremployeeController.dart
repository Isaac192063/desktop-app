import 'dart:io';
import 'package:desktop_app/config/environment.dart';
import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/providers/employess_provider.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/config/dio.dart';
import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class RegisterEmployeeController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? imagen;
  User? user;

  RegisterEmployeeController({this.user});

  void init(BuildContext context) {
    this.context = context;
    if (user != null) {
      nameController.text = user!.name;
      lastNameController.text = user!.lastName;
      emailController.text = user!.email;
      numberPhoneController.text = user!.phoneNumber;
      passwordController.text = "123456";
    }
  }

  void reset() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    lastNameController = TextEditingController();
    numberPhoneController = TextEditingController();
    passwordController = TextEditingController();
    imagen = null;
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
        res = await dio.put("${Environment.API_RDQ}/user/${user?.id}",
            data: formData);
      }

      Map<String, dynamic> json = res.data.cast<String, dynamic>();
      ResponseApi responseApi = ResponseApi.fromJson(json);

      if (responseApi.success!) {
        notification(
          context!,
          responseApi.message!,
          "sucess",
          InfoBarSeverity.success,
        );
      } else {
        notification(
            context!, responseApi.message!, "alerta", InfoBarSeverity.warning);
      }

      context!.read<EmployeesProvider>().setEmployees();
      Navigator.pop(context!);
      if (user != null) {
        return Navigator.pop(context!);
      }
    } catch (e) {
      print(e.toString());
      notification(context!, "Error al registrar al empleado", "error",
          InfoBarSeverity.error);
    }
  }
}
