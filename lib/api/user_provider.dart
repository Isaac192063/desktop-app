import 'dart:convert';

import 'package:desktop_app/api/environment.dart';
import 'package:desktop_app/api/response_api.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _api = "/employee";
  BuildContext? context;

  Future<ResponseApi> login(String email, String password) async {
    try {
      String params = jsonEncode({"email": email, "password": password});

      final res = await http.post(
          Uri.parse("${Environment.API_RDQ}$_api/login"),
          headers: {'Content-type': 'application/json'},
          body: params);

      final data = jsonDecode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      return ResponseApi.fromJson(
          {'sucess': false, 'messge': "ocurrio un error"});
    }
  }
}
