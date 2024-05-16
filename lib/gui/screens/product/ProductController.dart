import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/service/Product_service.dart';

class ProductController {
  final Productservice _producService = Productservice();

  Future<List<Product>> getAllProducts() async {
    try {
      ResponseApi api = await _producService.getAllProducts();
      List prods = api.data;
      List<Product> listProducts =
          prods.map((e) => Product.fromJson(e)).toList();

      return listProducts;
    } catch (e) {
      return [];
    }
  }
}
