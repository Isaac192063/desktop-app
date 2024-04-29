import 'package:desktop_app/components/search_bar.dart';
import 'package:desktop_app/components/table.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Kardex extends StatefulWidget {
  const Kardex({super.key});

  @override
  State<Kardex> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Kardex> {
  List<String> headTale = [
    "Posesion",
    "Fecha de remision",
    "Factura de remision",
    "Envase",
    "Factura de recepcion",
    "Fecha de recepcion",
    "Direccion"
  ];
  List<String> content = [
    "juan",
    "2/feb/24",
    "5",
    "6A248",
    "Sin entregar",
    "Sin entregar",
    "Sin entregar"
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content:Column(
        children: [
          Container(
            color: MyColor.btnColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Registro del kardex",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Searchbar(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 42, vertical: 5),
            child: const Row(
              children: [
                Text(
                  "Ubicacion actual: cra 27 14-47",
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Precio: 30.000"),
              ],
            ),
          ),
          table(context, 8, headTale, content)
          // ListView.builder(

          //   itemBuilder:
          //   ),
        ],
      ),
    );
  }
}
