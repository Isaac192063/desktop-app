import 'dart:ffi';
import 'dart:ui';

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
        content: Container(
      color: MyColor.primaryKey,
      child: SingleChildScrollView(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [registroCompra(), inventario()]),
      ),
    ));
  }

  Widget datosProductVender(String type, {String value = ""}) {
    return Container(
        margin: const EdgeInsets.all(10), child: Text("$type: $value"));
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                    child: const Text('Registro de venta'), onPressed: () {}),
                FilledButton(
                    child: const Text('Buscar Cliente'), onPressed: () {}),
              ],
            ),
            Text("Datos del cliente"),
            const TextBox(
              placeholder: 'Name',
            ),
            const TextBox(
              placeholder: 'Name',
            ),
            const TextBox(
              placeholder: 'Name',
            ),
            const TextBox(
              placeholder: 'Name',
            ),
            const TextBox(
              placeholder: 'Name',
            ),
            const TextBox(
              placeholder: 'Name',
            ),
            const TextBox(
              placeholder: 'Name',
            ),
            datosProductVender("Serial"),
            datosProductVender("Ubicacion actual"),
            datosProductVender("Precio"),
            datosProductVender("Capacidad"),
            const TextBox(
              placeholder: 'Name',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                    child: const Text('Agregar Producto'), onPressed: () {}),
                FilledButton(
                    child: const Text('Registrar pedido'), onPressed: () {}),
              ],
            ),
          ]),
    );
  }

  Widget inventario() {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Column(children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              AutoSuggestBox(
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
            ],
          ),
        ),
      ]),
    );
  }
}
