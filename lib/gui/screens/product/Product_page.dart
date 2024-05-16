import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/models/Product_model.dart';
import 'package:desktop_app/gui/screens/product/ProductController.dart';
import 'package:desktop_app/gui/widgets/table.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<String> headersProduct = ["Serial", "Tipo de producto", "Precio"];
  String selectedCat = "";
  bool disabled = false;

  List<Product2> produtList = productListItems;
  final ProductController _productController = ProductController();
  late Future<List<Product>> listProducts;

  @override
  void initState() {
    super.initState();
    listProducts = _productController.getAllProducts();
  }

  List<String> cats = ["dsgdfh", "wdwgefgh", "wdgdefh"];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Column(
          children: [searchEmployee(context), checkBox(cats)],
        ),
      ),
    );
  }

  Widget searchEmployee(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width / 2,
      child: AutoSuggestBox<Product2>(
        onChanged: (text, reason) {
          // searchEmpServer(text);
        },
        placeholder: "Buscar envase",
        leadingIcon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(FluentIcons.search),
        ),
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 252, 255, 254)),
        items: produtList.map((product) {
          return AutoSuggestBoxItem<Product2>(
              value: product, label: product.content);
        }).toList(),
        onSelected: (value) {
          // detalleEmployee(context, value.value!);
        },
      ),
    );
  }

  Widget checkBox(List list) {
    return ComboBox<String>(
      value: selectedCat,
      items: list.map<ComboBoxItem<String>>((e) {
        return ComboBoxItem<String>(
          child: Text(e),
          value: e,
        );
      }).toList(),
      onChanged: disabled
          ? null
          : (color) {
              setState(() => selectedCat = color!);
            },
      placeholder: const Text('Select a cat breed'),
    );
  }
}
