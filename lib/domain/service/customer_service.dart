import 'dart:convert';

import 'package:desktop_app/config/environment.dart';
import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  final String _api = "/customer";

  Future<ResponseApi> getAllCustomers() async {
    try {
      final sol = await http.get(Uri.parse("${Environment.API_RDQ}$_api"),
          headers: {'content-type': 'application/json'});

      final res = json.decode(sol.body);
      ResponseApi responseApi = ResponseApi.fromJson(res);
      return responseApi;
    } catch (e) {
      print(e);
      return ResponseApi.fromJson(
          {'success': false, 'message': "Ocurrio un error"});
    }
  }

  Future<ResponseApi> newCustomer(Customer customer) async {
    try {
      final req = json.encode(customer.toJson());

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

 Future<ResponseApi> editCustomerService(Customer customer) async {
    try {
      final req = json.encode(customer.toJson());

      final sol = await http.put(
        Uri.parse("${Environment.API_RDQ}$_api/${customer.identification}"),
        headers: {'Content-type': 'application/json'},
        body: req,
      );

      final res = jsonDecode(sol.body);

      print(res);

      ResponseApi api = ResponseApi.fromJson(res);

      return api;
    } catch (e) {
      return ResponseApi.fromJson(
          {'success': false, 'message': "Ocurrió un error"});
    }
  }
  
  Future<List<City>> getAllCities() async {
    try {
      final sol = await http.get(
        Uri.parse("${Environment.API_RDQ}/city"),
        headers: {'Content-type': 'application/json'},
      );

      final res = json.decode(sol.body);

      List data = res;

      List<City> listCities = data.map((e) => City.fromJson(e)).toList();

      return listCities;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ResponseApi> toggleCustomer(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("${Environment.API_RDQ}$_api/$id"),
        headers: {'Content-type': 'application/json'},
      );

      final res = jsonDecode(response.body);

      ResponseApi api = ResponseApi.fromJson(res);
      print(api);
      return api;
    } catch (e) {
      print(e);
      return ResponseApi.fromJson(
          {'success': false, 'message': "ocurrio un error"});
    }
  }
}
