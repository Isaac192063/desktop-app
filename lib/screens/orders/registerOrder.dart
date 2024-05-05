import 'package:desktop_app/api/models/Product_model.dart';
import 'package:desktop_app/components/search_bar.dart';
import 'package:desktop_app/components/table.dart';
import 'package:desktop_app/screens/orders/showOrder.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

class RegisterOrder extends StatefulWidget {
  const RegisterOrder({super.key});

  @override
  State<RegisterOrder> createState() => _nameState();
}

class _nameState extends State<RegisterOrder> {
  Cat? selectedObjectCat;
  String? selectedPaymentMethod = "Nequi";
  List<String> paymentMethods = ["Nequi", "Daviplata", "tarjetas de credito"];
  String? selectedProcess = "Remision";
  List<String> tipeOfProcesses = ["Remision", "Recepcion"];
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

  @override
  Widget build(BuildContext context) {
    return fluent_ui.ScaffoldPage(
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
  }

  Widget button(String description, Function asa) {
    return FilledButton(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                child: textModified("productos Seleccionados", 16)),
            Container(
                // width: 200, child: table(context, 2, serial, tipoproduct)
                ),
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
                child: fluent_ui.Checkbox(
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
              fluent_ui.Checkbox(
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
    );
  }

  Widget registroCompra() {
    return SizedBox(
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
            const fluent_ui.TextBox(
              placeholder: 'Nombre',
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
            ),
            const fluent_ui.TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Cedula',
            ),
            const fluent_ui.TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Ciudad de residencia',
            ),
            const fluent_ui.TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Telefono',
            ),
            const fluent_ui.TextBox(
              placeholderStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              padding: EdgeInsets.all(10),
              placeholder: 'Direccion',
            ),
            Row(
              children: [
                SizedBox(
                  child: fluent_ui.ComboBox<String>(
                    value: selectedProcess,
                    items: tipeOfProcesses
                        .map<fluent_ui.ComboBoxItem<String>>((String e) {
                      return fluent_ui.ComboBoxItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (process) =>
                        setState(() => selectedProcess = process),
                    placeholder: const Text(
                      'hola',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                SizedBox(
                  child: fluent_ui.ComboBox<String>(
                    value: selectedPaymentMethod,
                    items: paymentMethods
                        .map<fluent_ui.ComboBoxItem<String>>((String e) {
                      return fluent_ui.ComboBoxItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (paymentMethod) =>
                        setState(() => selectedPaymentMethod = paymentMethod),
                    placeholder: const Text(
                      'hola',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
            
            // fluent_ui.NumberBox(
            //   value: numberBoxValueMinMax,
            //   min: 0,
            //   max: 20,
            //   onChanged: _valueChangedMinMax,
            //   mode: fluent_ui.SpinButtonPlacementMode.inline,
            //   placeholder: "Cantidad de cilindros",
            //   leadingIcon: const Padding(
            //     padding: EdgeInsets.all(10.0),
            //     child: Icon(fluent_ui.FluentIcons.number_field),
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     button("Agregar Producto", () {}),
            //     FilledButton(
            //         child: const Text('Registrar pedido',
            //             style: TextStyle(
            //                 fontSize: 16, fontWeight: FontWeight.w400)),
            //         onPressed: () {}),
            //   ],
            // ),
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
            const Searchbar(),
            fluent_ui.Align(
              alignment: Alignment.topCenter,
              child: fluent_ui.SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: fluent_ui.SingleChildScrollView(
                  child: fluent_ui.SizedBox(

                    width: 587,
                    child: DataTable(
                      columnSpacing: 2,

                      dataRowHeight: 40,
                      border: const fluent_ui.TableBorder(
                        horizontalInside: fluent_ui.BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                        // verticalInside: fluent_ui.BorderSide(
                        //   color: Colors.grey,
                        //   width: 0.3,

                        // ),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: fluent_ui.BorderSide(
                              width: 1, color: Colors.grey),
                        ),
                      ),
                      columns: [
                        tableHeaderColumn('Serial', 17),
                        tableHeaderColumn('Tipo de producto', 17),
                        tableHeaderColumn('Precio', 17),
                        tableHeaderColumn('Seleccionar', 17),
                      ],
                      rows: List.generate(productListItems.length, (index) {
                        final productListItem = productListItems[index];
                        return _customListTile(
                            productListItem: productListItem, context: context);
                      }),
                    ),
                  ),
                ),
              ),
            )
            // detailProduct()
          ],
        ),
      ),
    );
  }

  DataRow _customListTile({
    required Product productListItem,
    required context,
  }) {
    return DataRow(cells: [
      DataCell(Text(productListItem.id)),
      DataCell(Text(productListItem.content)),
      DataCell(Text(productListItem.price.toString())),
      DataCell(
        fluent_ui.Row(
          children: [
            IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }
                      return Colors.white;
                    },
                  ),
                ),
                icon: const Icon(fluent_ui.FluentIcons.check_mark, size: 15),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowOrder()),
                    )),
          ],
        ),
      ),
    ]);
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
