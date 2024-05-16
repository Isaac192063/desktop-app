import 'dart:convert';

import 'package:desktop_app/config/environment.dart';
import 'package:desktop_app/config/response_api.dart';
import 'package:http/http.dart' as http;

class Productservice {
  final String _api = "/product";

  Future<ResponseApi> getAllProducts() async {
    try {
      final sol = await http.get(
        Uri.parse("${Environment.API_RDQ}$_api"),
        headers: {'Content-type': 'application/json'},
      );

      final res = json.decode(sol.body);

      ResponseApi responseApi = ResponseApi.fromJson(res);

      return responseApi;
    } catch (e) {
      return ResponseApi.fromJson(
          {'success': false, 'message': "ocurrio un error"});
    }
  }
}
