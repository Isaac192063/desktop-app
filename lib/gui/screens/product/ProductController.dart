import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/service/Product_service.dart';
import 'package:flutter/material.dart';

class ProductController {
  final Productservice _producService = Productservice();
  TextEditingController cod = TextEditingController();
  TextEditingController owner = TextEditingController();
  TypePackaging? typePackaging;
  Content? content;
  DateTime? time;

  void init({Packaging? packaging}) {
    cod.text = packaging!.id!;
    owner.text = packaging.owner!;
    typePackaging = packaging.typePackaging;
    content = packaging.content;
    time = DateTime.tryParse(packaging.hydrostaticDate!);
    print(packaging.owner);
  }

  void delete() {
    cod = TextEditingController();
    owner = TextEditingController();
    typePackaging = null;
    content = null;
    time = null;
  }

  Future<List<Packaging>> getAllProduct() async {
    try {
      ResponseApi api = await _producService.getAllProducts();
      List data = api.data;
      List<Packaging> listPackagings =
          data.map((e) => Packaging.fromJson(e)).toList();
      return listPackagings;
    } catch (e) {
      return [];
    }
  }

  Future<void> registerPackaging() async {
    print(cod.text);
    print(owner.text);
    print(typePackaging);
    print(content);
    print(time);

    try {
      Packaging packaging = Packaging(
          id: cod.text,
          hydrostaticDate: time!.toIso8601String(),
          owner: owner.text,
          content: content,
          typePackaging: typePackaging);
      ResponseApi api = await _producService.newPackgagin(packaging);
      print(api.success);
    } catch (e) {
      print(e);
    }
  }
}
