import 'dart:convert';

import 'package:desktop_app/config/environment.dart';
import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/Product.dart';
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
      print(e);
      return ResponseApi.fromJson(
          {'success': false, 'message': "ocurrio un error"});
    }
  }

  Future<List<Content>> getAllContent() async {
    try {
      final sol = await http.get(
        Uri.parse("${Environment.API_RDQ}$_api/content"),
        headers: {'Content-type': 'application/json'},
      );

      final res = json.decode(sol.body);
      List list = res;
      List<Content> listContent = list.map((e) => Content.fromJson(e)).toList();
      return listContent;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TypePackaging>> getAllTypeContent() async {
    try {
      final sol = await http.get(
        Uri.parse("${Environment.API_RDQ}$_api/typePackaging"),
        headers: {'Content-type': 'application/json'},
      );

      final res = json.decode(sol.body);

      List data = res;

      List<TypePackaging> listProducts =
          data.map((e) => TypePackaging.fromJson(e)).toList();

      return listProducts;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ResponseApi> newPackgagin(Packaging pkg) async {
    try {
      final req = json.encode(pkg.toJson());

      final sol = await http.post(Uri.parse("${Environment.API_RDQ}$_api"),
          headers: {'Content-type': 'application/json'}, body: req);

      final res = jsonDecode(sol.body);

      print(res);

      ResponseApi api = ResponseApi.fromJson(res);

      return api;
    } catch (e) {
      return ResponseApi.fromJson(
          {'success': false, 'message': "ocurrio un error"});
    }
  }

  Future<List<Packaging>> findPackagingByCod(String code) async {
    try {
      final sol = await http.get(
        Uri.parse("${Environment.API_RDQ}$_api?cod=$code"),
        headers: {'Content-type': 'application/json'},
      );

      final res = jsonDecode(sol.body);

      List data = res;

      List<Packaging> listPackaging =
          data.map((e) => Packaging.fromJson(e)).toList();

      return listPackaging;
    } catch (e) {
      print("object");
      print(e);
      return [];
    }
  }

  Future<ResponseApi> updateProduct(String id, Packaging packaging) async {
    try {
      final data = jsonEncode(packaging.toJson());

      final response = await http.put(
        Uri.parse("${Environment.API_RDQ}$_api/$id"),
        body: data,
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
