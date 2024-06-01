import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/service/Product_service.dart';
import 'package:desktop_app/gui/screens/product/ProductController.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Register_edit_packaging extends StatefulWidget {
  final ProductController _con;

  const Register_edit_packaging(this._con, {super.key});

  @override
  State<Register_edit_packaging> createState() => _nameState();
}

class _nameState extends State<Register_edit_packaging> {
  late Future<List<TypePackaging>> listProductsType;
  late Future<List<Content>> listContent;
  final Productservice productService = Productservice();
  DateTime? selected;

  ProductController? _con;

  TypePackaging? typePackagaging;
  Content? content;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    listProductsType = productService.getAllTypeContent();
    listContent = productService.getAllContent();
    _con = widget._con;
    content = _con!.content;
    typePackagaging = _con!.typePackaging;
    selected = _con!.time;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Codigo del cilindro',
              controller: _con!.cod,
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'dueño',
              controller: _con!.owner,
            ),
            const SizedBox(
              height: 20,
            ),
            checkBoxContent(listContent, "seleccione el contenido"),
            const SizedBox(
              height: 10,
            ),
            checkBoxType(listProductsType, "seleccione el tamaño"),
            const SizedBox(
              height: 20,
            ),
            DatePicker(
              header: 'Prueba hidrostatica',
              selected: selected,
              headerStyle: const TextStyle(fontSize: 18),
              contentPadding: const EdgeInsets.all(5),
              onChanged: (time) => setState(() {
                _con!.time = time;
                selected = time;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkBoxType(Future<List<TypePackaging>> list, String title) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TypePackaging> listPackaging = snapshot.data!;
          return ComboBox<TypePackaging>(
            value: typePackagaging,
            items: listPackaging.map<ComboBoxItem<TypePackaging>>((e) {
              return ComboBoxItem<TypePackaging>(
                value: e,
                child: Text("${e.size.toString()} ${e.pressureAmount}"),
              );
            }).toList(),
            onChanged: disabled
                ? null
                : (color) {
                    _con!.typePackaging = color!;
                    setState(() {
                      typePackagaging = color;
                    });
                  },
            placeholder: typePackagaging == null
                ? Text(title)
                : Text(
                    "${typePackagaging!.size.toString()} ${typePackagaging!.pressureAmount}"),
          );
        }

        return ProgressRing();
      },
    );
  }

  Widget checkBoxContent(Future<List<Content>> list, String title) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Content> listPackaging = snapshot.data!;
          return ComboBox<Content>(
            value: content,
            items: listPackaging.map<ComboBoxItem<Content>>((e) {
              return ComboBoxItem<Content>(
                child: Text(e.name!),
                value: e,
              );
            }).toList(),
            onChanged: disabled
                ? null
                : (color) {
                    _con!.content = color!;
                    setState(() => content = color);
                  },
            placeholder: content == null ? Text(title) : Text(content!.name!),
          );
        }

        return ProgressRing();
      },
    );
  }
}
