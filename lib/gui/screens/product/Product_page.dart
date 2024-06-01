import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:desktop_app/gui/screens/product/ProductController.dart';
import 'package:desktop_app/gui/screens/product/register_product.dart';
import 'package:desktop_app/gui/screens/product/search_product.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController _con = ProductController();
  late Future<List<Packaging>> listPackaging;

  @override
  void initState() {
    super.initState();
    listPackaging = _con.getAllProduct();
  }

// Ventana mergenete
  void showContentDialog(BuildContext context,
      {edit = false, Packaging? pkg}) async {
    if (pkg != null) {
      _con.init(packaging: pkg);
    } else {
      _con.delete();
    }
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
        title:
            edit ? const Text('Editar envase') : const Text('Agregar envase'),
        content: Register_edit_packaging(_con),
        actions: [
          Button(
            child: const Text('Agregar'),
            onPressed: () async {
              await _con.registerPackaging();
              Navigator.pop(context, 'User deleted file');
              setState(() {
                listPackaging = _con.getAllProduct();
                print("object hola munedo");
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
  }

  void showPackaging(BuildContext context, Packaging packaging) async {
    Widget setText(String text, double size, bool negrilla) {
      return Text(
        text,
        style: TextStyle(
            fontSize: size,
            fontWeight: negrilla ? FontWeight.w600 : FontWeight.normal),
      );
    }

    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 600),
        title: const Text('Visualizar envase'),
        content: Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Transform(
                      transform: Matrix4.rotationZ(-0.2),
                      origin: Offset.fromDirection(15),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0.0, 40.0),
                                  blurRadius: 20.0,
                                ),
                              ],
                              color: editColor(packaging.content!.color!),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0.0, 20.0),
                                  blurRadius: 20.0,
                                ),
                              ],
                              color: editColor(packaging.content!.color!),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      packaging.content!.name!,
                      style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        setText("Codigo", 25, true),
                        setText(packaging.id!, 20, false),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 190,
                          color: Colors.black,
                          height: 0.3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        setText("prueba hisdrostatica", 22, true),
                        setText(
                            DateFormat("yyyy-MM-dd").format(
                                DateTime.tryParse(packaging.hydrostaticDate!)!),
                            19,
                            false),
                        const SizedBox(
                          height: 30,
                        ),
                        setText("Dueño del cilindro", 22, true),
                        setText(packaging.owner!, 19, false),
                        const SizedBox(
                          height: 35,
                        ),
                        setText("Tamaño del cilindro", 22, true),
                        setText(
                            "${packaging.typePackaging!.size} ${packaging.typePackaging!.pressureAmount}",
                            19,
                            false),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Button(
                            onPressed: () {
                              showContentDialog(context,
                                  edit: true, pkg: packaging);
                            },
                            style: ButtonStyle(
                                padding: ButtonState.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30))),
                            child: const Text('Editar')),
                        const SizedBox(
                          width: 20,
                        ),
                        FilledButton(
                            onPressed: () =>
                                Navigator.pop(context, 'User canceled dialog'),
                            style: ButtonStyle(
                                padding: ButtonState.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30))),
                            child: const Text('Cancelar')),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Column(
          children: [
            SearchPackaging(showPackaging),
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
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: textModified(pkg.id!, 20,
                                        color: Colors.white),
                                  ),
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

  Color editColor(String color) {
    Map<String, Color> colorEdit = {
      "gris os": const Color.fromARGB(255, 32, 32, 32),
      "azul verdoso": const Color.fromARGB(255, 28, 124, 94),
      "dorado": const Color.fromARGB(255, 86, 82, 57),
      "negro": Colors.black,
      "gris": const Color.fromARGB(255, 76, 76, 76),
      "Verde": const Color.fromARGB(255, 38, 93, 21)
    };

    return colorEdit[color]!;
  }
}
