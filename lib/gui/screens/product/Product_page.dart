import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:desktop_app/gui/screens/product/ProductController.dart';
import 'package:desktop_app/gui/screens/product/register_product.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductController _con = ProductController();
  late Future<List<Packaging>> listPackaging;

  @override
  void initState() {
    super.initState();
    listPackaging = _con.getAllProduct();
  }

// Ventana mergenete
  void showContentDialog(BuildContext context) async {
    ProductController con = ProductController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
        title: Text('Agregar envase'),
        content: Register_edit_packaging(con),
        actions: [
          Button(
            child: const Text('Agregar'),
            onPressed: () {
              con.registerPackaging();
              Navigator.pop(context, 'User deleted file');
              setState(() {
                listPackaging = _con.getAllProduct();
              });
            },
          ),
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }

  void showPackaging(BuildContext context, Packaging packaging) async {
    ProductController con = ProductController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
        title: Text('Agregar envase'),
        content: Container(
          child: Column(
            children: [Text(packaging.owner!)],
          ),
        ),
        actions: [
          Button(
            child: const Text('Editar'),
            onPressed: () {
              Navigator.pop(context, 'User deleted file');
            },
          ),
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }

  String selectedContact = '';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Column(
          children: [
            searchEmployee(context),
            FutureBuilder(
              future: listPackaging,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Packaging> pkgs = snapshot.data!;
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                        itemCount: pkgs.length,
                        itemBuilder: (context, index) {
                          final pkg = pkgs[index];
                          return ListTile.selectable(
                            leading: SizedBox(
                              height: 100,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ColoredBox(
                                  color: editColor(pkg.content!.color!),
                                  child: const Placeholder(),
                                ),
                              ),
                            ),
                            title: Text(pkg.content!.name!),
                            subtitle: Text("Dueño: ${pkg.owner!}"),
                            selectionMode: ListTileSelectionMode.single,
                            onPressed: () {
                              showPackaging(context, pkg);
                            },
                          );
                        }),
                  );
                }
                return const ProgressRing();
              },
            ),
            button(context, "Agregar Producto", () {
              showContentDialog(context);
            }, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget searchEmployee(context) {
    List<String> pdts = ["hfhrfgh", "fgrfgh"];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width / 2,
      child: AutoSuggestBox<String>(
        onChanged: (text, reason) {
          // searchEmpServer(text);
        },
        placeholder: "Buscar Envase",
        leadingIcon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(FluentIcons.search),
        ),
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 252, 255, 254)),
        items: pdts.map((employee) {
          return AutoSuggestBoxItem<String>(value: employee, label: employee);
        }).toList(),
        onSelected: (value) {
          // detalleEmployee(context, value.label);
        },
      ),
    );
  }

  Color editColor(String color) {
    Map<String, Color> colorEdit = {
      "gris os": const Color.fromARGB(255, 32, 32, 32),
      "azul verdoso": Color.fromARGB(255, 28, 124, 94),
      "dorado": Color.fromARGB(255, 86, 82, 57),
      "negro": Colors.black,
      "gris": const Color.fromARGB(255, 76, 76, 76),
      "Verde": Color.fromARGB(255, 38, 93, 21)
    };

    return colorEdit[color]!;
  }
}
