import 'dart:ui';
import 'package:desktop_app/widgets/table.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class PrimeraScreen extends StatefulWidget {
  const PrimeraScreen({super.key});

  @override
  State<PrimeraScreen> createState() => _nameState();
}

class Cat {
  final int id;
  final String name;
  final bool hasTag;

  const Cat(this.id, this.name, this.hasTag);
}

class _nameState extends State<PrimeraScreen> {
  Cat? selectedObjectCat;
  String option = "";
  List<String> cat = ["Nequi", "Daviplata", "tarjetas de credito"];
  int numberBoxValueMinMax = 0;
  bool checkedPrice = false;
  bool checkedType = false;
  List<String> headTale = ["Serial", "tipo de producto", "Precio"];
  List<String> content = ["text", "text", "text"];
  List<String> serial = [
    "Serial",
    "tipo ",
  ];
  List<String> tipoproduct = ["text", "text"];

  List<Cat> objectCats = [
    Cat(1, 'Abyssinian', true),
    Cat(2, 'Aegean', true),
    Cat(3, 'American Bobtail', false),
    Cat(4, 'American Curl', true),
    Cat(5, 'American Ringtail', false),
    Cat(6, 'American Shorthair', true),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: EdgeInsets.zero,
        content: Container(
          color: MyColor.primaryKey,
          child: SingleChildScrollView(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [registroCompra(), inventario()]),
          ),
        ));
  }

  Widget dataProductShell(String type, {String value = ""}) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Text("$type: $value",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
  }

  Widget button(String description, Function asa) {
    return FilledButton(
        style: ButtonStyle(
          padding: ButtonState.all(
              const EdgeInsets.symmetric(vertical: 8, horizontal: 20)),
        ),
        child: Text(description,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        onPressed: () {
          asa();
        });
  }

  Widget alert(String description) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: MyColor.btnColor),
      child: Text(description,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    );
  }

  Widget textModified(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w400),
    );
  }

  Widget detailProduct() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 20),
                  child: textModified("productos Seleccionados", 16)),
              Container(
                  width: 200, child: table(context, 2, serial, tipoproduct)),
              Container(
                margin: const EdgeInsets.all(15.0),
                child: button("modificar peiddos", () {}),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                alert("Buscar por"),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Checkbox(
                    checked: checkedType,
                    onChanged: (value) {
                      setState(() {
                        checkedType = value ?? false;
                      });
                    },
                    content: textModified(
                      "Tipo de documento",
                      15,
                    ),
                  ),
                ),
                Checkbox(
                  checked: checkedPrice,
                  onChanged: (value) {
                    setState(() {
                      checkedPrice = value ?? false;
                    });
                  },
                  content: textModified("precio", 15),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget registroCompra() {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                alert("Registro de venta"),
                button("Buscar cliente", () {}),
              ],
            ),
            const Text(
              "Datos del cliente",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const TextBox(
              placeholder: 'Nombre',
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
            ),
            const TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Cedula',
            ),
            const TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Ciudad de residencia',
            ),
            const TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Telefono',
            ),
            const TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Direccion',
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ComboBox<String>(
                value: option,
                items: cat.map<ComboBoxItem<String>>((String e) {
                  return ComboBoxItem<String>(
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {},
                placeholder: const Text(
                  'Seleccione el metodo de pago',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: alert("Datos del producto a vender"),
            ),
            dataProductShell("Serial"),
            dataProductShell("Ubicacion actual"),
            dataProductShell("Precio"),
            dataProductShell("Capacidad"),
            NumberBox(
              value: numberBoxValueMinMax,
              min: 0,
              max: 20,
              onChanged: _valueChangedMinMax,
              mode: SpinButtonPlacementMode.inline,
              placeholder: "Cantidad de cilindros",
              leadingIcon: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(FluentIcons.number_field),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button("Agregar Producto", () {}),
                FilledButton(
                    style: ButtonStyle(
                      padding: ButtonState.all(const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8)),
                    ),
                    child: const Text('Registrar pedido',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    onPressed: () {}),
              ],
            ),
          ]),
    );
  }

  Widget inventario() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        color: MyColor.bgOrder,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: AutoSuggestBox(
                  selectionWidthStyle: BoxWidthStyle.max,
                  placeholder: "Buscar en inventario",
                  leadingIcon: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(FluentIcons.search),
                  ),
                  items: objectCats
                      .map<AutoSuggestBoxItem<Cat>>(
                        (cat) => AutoSuggestBoxItem<Cat>(
                          value: cat,
                          label: cat.name,
                          onFocusChange: (focused) {
                            if (focused) {
                              debugPrint('Focused #${cat.id} - ${cat.name}');
                            }
                          },
                        ),
                      )
                      .toList(),
                  onSelected: null),
            ),
            table(context, 8, headTale, content),
            detailProduct()
          ],
        ),
      ),
    );
  }

// logic

  void _valueChangedMinMax(int? newValue) {
    if (newValue != null) {
      setState(() {
        numberBoxValueMinMax = newValue;
      });
    }
  }
}
