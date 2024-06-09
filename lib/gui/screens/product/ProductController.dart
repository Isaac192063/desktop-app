import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/service/Product_service.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class ProductController {
  final Productservice _producService = Productservice();
  TextEditingController cod = TextEditingController();
  TextEditingController owner = TextEditingController();
  TypePackaging? typePackaging;
  Content? content;
  DateTime? time;
  Packaging? packaging;
  BuildContext? context;

  void init(BuildContext context, {Packaging? packaging}) {
    cod.text = packaging!.id!;
    owner.text = packaging.owner!;
    typePackaging = packaging.typePackaging;
    content = packaging.content;
    time = DateTime.tryParse(packaging.hydrostaticDate!);
    this.context = context;
    this.packaging = packaging;
    print(packaging.owner);
  }

  void delete() {
    cod = TextEditingController();
    owner = TextEditingController();
    typePackaging = null;
    content = null;
    time = null;
    packaging = null;
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
    if (packaging != null) {
      await updateProduct();
    } else {
      await registerProduct();
    }
  }

  Future<void> registerProduct() async {
    try {
      Packaging packaging = Packaging(
          id: cod.text,
          hydrostaticDate: time!.toIso8601String(),
          owner: owner.text,
          content: content,
          typePackaging: typePackaging);
      ResponseApi api = await _producService.newPackgagin(packaging);
      notification(context!, api.message!, "Success", InfoBarSeverity.success);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProduct() async {
    try {
      Packaging packagingUpdate = Packaging(
          hydrostaticDate: time!.toIso8601String(),
          owner: owner.text,
          content: content,
          typePackaging: typePackaging);
      ResponseApi api =
          await _producService.updateProduct(cod.text, packagingUpdate);
      notification(context!, api.message!, "Success", InfoBarSeverity.success);
      Navigator.pop(context!);
    } catch (e) {
      print(e);
    }
  }
}
