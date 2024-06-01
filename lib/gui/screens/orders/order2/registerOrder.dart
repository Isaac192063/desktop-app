import 'package:desktop_app/gui/screens/orders/order2/Product_model.dart';
import 'package:desktop_app/gui/screens/orders/order2/detail_order_model.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/table.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

class RegisterOrder extends StatefulWidget {
  const RegisterOrder({super.key});

  @override
  State<RegisterOrder> createState() => _nameState();
}

class _nameState extends State<RegisterOrder> {
  List<String> paymentMethods = ["Credito", "Contado"];
  List<String> tipeOfProcesses = ["Remision", "Recepcion"];
  String? selectedPaymentMethod = "Credito";
  String? selectedProcess = "Remision";
  String? selectedProduct;
  String? selectedClient;
  int numberBoxValueMinMax = 0;
  Map<String, Product> productMap = {};
  @override
  void initState() {
    super.initState();
    for (var product in productListItems) {
      productMap[product.toString()] = product;
    }
  }

  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return fluent_ui.ScaffoldPage(
        header: Container(
          color: MyColor.btnColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Registro de ventas",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        padding: EdgeInsets.zero,
        content: fluent_ui.Column(
          children: [
            fluent_ui.Container(
              color: Colors.white,
              child: fluent_ui.Padding(
                padding: const EdgeInsets.all(8.0),
                child: fluent_ui.Row(
                  children: [
                    fluent_ui.InfoLabel(
                      label: 'Producto',
                      child: fluent_ui.SizedBox(
                        width: 170,
                        child: fluent_ui.AutoSuggestBox<String>(
                          placeholder: 'Seleccione un producto',
                          items: productListItems.map((product) {
                            return fluent_ui.AutoSuggestBoxItem<String>(
                              value: product.toString(),
                              label: product.toString(),
                              onFocusChange: (focused) {
                                if (focused) {
                                  debugPrint('Focused $product');
                                }
                              },
                            );
                          }).toList(),
                          onSelected: (item) {
                            setState(() {
                              selectedProduct = item.value!;
                              if (productMap[selectedProduct] != null) {
                                _productPriceController.text =
                                    productMap[selectedProduct]!
                                        .price
                                        .toString();
                                _productTypeController.text =
                                    productMap[selectedProduct]!.content;
                                _productStockController.text =
                                    productMap[selectedProduct]!
                                        .stock
                                        .toString();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    const fluent_ui.SizedBox(
                      width: 20,
                    ),
                    fluent_ui.SizedBox(
                      width: 150,
                      child: fluent_ui.InfoLabel(
                        label: 'Tipo de producto',
                        child: fluent_ui.TextBox(
                          enabled: false,
                          expands: false,
                          controller: _productTypeController,
                        ),
                      ),
                    ),
                    const fluent_ui.SizedBox(
                      width: 20,
                    ),
                    fluent_ui.SizedBox(
                      width: 160,
                      child: fluent_ui.InfoLabel(
                        label: 'Stock del mismo tipo',
                        child: fluent_ui.TextBox(
                          enabled: false,
                          expands: false,
                          controller: _productStockController,
                        ),
                      ),
                    ),
                    const fluent_ui.SizedBox(
                      width: 20,
                    ),
                    fluent_ui.InfoLabel(
                      label: 'Cliente',
                      child: fluent_ui.SizedBox(
                        width: 170,
                        child: fluent_ui.AutoSuggestBox<String>(
                          placeholder: 'Seleccione un cliente',
                          items: productListItems.map((product) {
                            return fluent_ui.AutoSuggestBoxItem<String>(
                              value: product.toString(),
                              label: product.toString(),
                              onFocusChange: (focused) {
                                if (focused) {
                                  debugPrint('Focused $product');
                                }
                              },
                            );
                          }).toList(),
                          onSelected: (item) {
                            // setState(() {
                            //   selectedProduct = productMap[item] as String?;
                            // });
                          },
                        ),
                      ),
                    ),
                    const fluent_ui.SizedBox(
                      width: 20,
                    ),
                    fluent_ui.Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: fluent_ui.FilledButton(
                        style: fluent_ui.ButtonStyle(
                          shape: fluent_ui.ButtonState.all(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Bordes suaves
                            ),
                          ),
                          padding: fluent_ui.ButtonState.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Espaciado interno
                          ),
                          textStyle: fluent_ui.ButtonState.all(
                            const TextStyle(
                              fontSize: 16, // Tamaño del texto
                            ),
                          ),
                        ),
                        onPressed: () {
                          print(selectedProduct);
                          if (selectedProduct != "") {
                            DetailOrder detailOrder = DetailOrder(
                                quantity: productMap[selectedProduct]!.quantity,
                                idOrder: productMap[selectedProduct]!.id,
                                idProduct: selectedProduct.toString(),
                                content: productMap[selectedProduct]!.content,
                                price: productMap[selectedProduct]!.price,
                                supplier:
                                    productMap[selectedProduct]!.supplier);
                            setState(() {
                              detailOrderListitems.add(detailOrder);
                              selectedProduct = "";
                            });
                            _productPriceController.text = "";
                            _productTypeController.text = "";
                            _productStockController.text = "";
                          } else {
                            print("campos no ingresados");
                          }
                        },
                        child: const Text('Agregar'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            inventario(),
            fluent_ui.Container(
              color: MyColor.white,
              child: fluent_ui.Padding(
                padding: const EdgeInsets.all(8.0),
                child: fluent_ui.Row(
                  children: [
                    fluent_ui.InfoLabel(
                      label: "Tipo de proceso",
                      child: SizedBox(
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
                        ),
                      ),
                    ),
                    const fluent_ui.SizedBox(
                      width: 20,
                    ),
                    fluent_ui.InfoLabel(
                      label: "Metodo de pago",
                      child: SizedBox(
                        child: fluent_ui.ComboBox<String>(
                          value: selectedPaymentMethod,
                          items: paymentMethods
                              .map<fluent_ui.ComboBoxItem<String>>((String e) {
                            return fluent_ui.ComboBoxItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (paymentMethod) => setState(
                              () => selectedPaymentMethod = paymentMethod),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    fluent_ui.Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: fluent_ui.FilledButton(
                        style: fluent_ui.ButtonStyle(
                          shape: fluent_ui.ButtonState.all(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Bordes suaves
                            ),
                          ),
                          padding: fluent_ui.ButtonState.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Espaciado interno
                          ),
                          textStyle: fluent_ui.ButtonState.all(
                            const TextStyle(
                              fontSize: 16, // Tamaño del texto
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Guardar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget inventario() {
    return fluent_ui.Align(
      alignment: Alignment.topCenter,
      child: fluent_ui.SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: fluent_ui.SingleChildScrollView(
          child: fluent_ui.SizedBox(
            width: fluent_ui.MediaQuery.of(context).size.width / 1.2,
            child: DataTable(
              dataRowHeight: 40,
              columnSpacing: 2,
              border: const fluent_ui.TableBorder(
                top: fluent_ui.BorderSide(strokeAlign: 1, color: Colors.grey),
                horizontalInside: fluent_ui.BorderSide(
                  color: Colors.grey,
                  width: 0.3,
                ),
                verticalInside: fluent_ui.BorderSide(
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
                  bottom: fluent_ui.BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              columns: [
                tableHeaderColumn('Cantidad', 17),
                tableHeaderColumn('Serial', 17),
                tableHeaderColumn('Tipo de producto', 17),
                tableHeaderColumn('Propiedad', 17),
                // tableHeaderColumn('Borrar', 17),
              ],
              rows: List.generate(detailOrderListitems.length, (index) {
                final detailOrder = detailOrderListitems[index];
                return _customListTile(
                    detailOrder: detailOrder, context: context);
              }),
            ),
          ),
        ),
      ),
    );
  }

  DataRow _customListTile({
    required DetailOrder detailOrder,
    required context,
  }) {
    return DataRow(cells: [
      DataCell(fluent_ui.Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(detailOrder.quantity),
      )),
      DataCell(fluent_ui.Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(detailOrder.idProduct),
      )),
      DataCell(fluent_ui.Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(detailOrder.content),
      )),
      DataCell(fluent_ui.Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(detailOrder.supplier),
      )),
      // DataCell(
      //   fluent_ui.Row(
      //     children: [
      //       IconButton(
      //           style: ButtonStyle(
      //             backgroundColor: WidgetStateProperty.resolveWith<Color?>(
      //               (Set<WidgetState> states) {
      //                 if (states.contains(WidgetState.pressed)) {
      //                   return Colors.red;
      //                 }
      //                 return Colors.white;
      //               },
      //             ),
      //           ),
      //           icon: const Icon(fluent_ui.FluentIcons.cancel, size: 15),
      //           onPressed: () {
      //             setState(() {
      //               detailOrderListitems.remove(detailOrder);
      //             });
      //           }),
      //     ],
      //   ),
      // ),
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
