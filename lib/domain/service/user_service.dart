import 'dart:convert';

import 'package:desktop_app/config/environment.dart';
import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/config/response_api.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _api = "/user";

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
          {'success': false, 'message': "ocurrio un error"});
    }
  }

  Future<ResponseApi> userById(String id) async {
    try {
      final res = await http.get(
        Uri.parse("${Environment.API_RDQ}$_api/$id"),
        headers: {'Content-type': 'application/json'},
      );

      final data = jsonDecode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      return ResponseApi.fromJson(
          {'success': false, 'message': "ocurrio un error"});
    }
  }

  Future<ResponseApi> getAllEmployes() async {
    try {
      final res = await http.get(
        Uri.parse("${Environment.API_RDQ}$_api/emp"),
        headers: {'Content-type': 'application/json'},
      );
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      return ResponseApi.fromJson(
          {'success': false, 'message': "ocurrio un error"});
    }
  }

  Future<List<User>> findByUserName(String name) async {
    final response = await http.get(
      Uri.parse("${Environment.API_RDQ}$_api/search?name=$name"),
      headers: {'Content-type': 'application/json'},
    );

    final res = jsonDecode(response.body);
    List<User> user = convertToUserList(res);

    return user;
  }

  Future<ResponseApi> toggleEmploye(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("${Environment.API_RDQ}$_api/$id"),
        headers: {'Content-type': 'application/json'},
      );

      final res = jsonDecode(response.body);

      ResponseApi api = ResponseApi.fromJson(res);
      return api;
    } catch (e) {
      return ResponseApi.fromJson(
          {'success': false, 'message': "ocurrio un error"});
    }
  }
}
