import 'package:desktop_app/api/models/Order_model.dart';
import 'package:desktop_app/components/search_bar.dart';
import 'package:desktop_app/components/table.dart';
import 'package:desktop_app/screens/registerOrder/registerOrder.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class IndexOrder extends StatefulWidget {
  const IndexOrder({super.key});

  @override
  State<IndexOrder> createState() => _IndexOrderState();
}

class _IndexOrderState extends State<IndexOrder> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Column(
        children: [
          Container(
            color: MyColor.btnColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Registro de ventas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Searchbar(),
          // material.TextButton(onPressed: () => Navigator.push(context, material.MaterialPageRoute(builder: (context) => const RegisterOrder())), child: const Text("Agregar nueva venta"), )
        ],
      ),
      content: material.Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: material.DataTable(
              dataRowHeight: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              columns: [
                tableHeaderColumn('Cantidad', 17),
                tableHeaderColumn('Descripcion', 17),
                tableHeaderColumn('Numero envase', 17),
                tableHeaderColumn('propietario', 17),
                tableHeaderColumn('lote', 17),
                tableHeaderColumn('Fecha ven', 17),
                tableHeaderColumn('Valor unit', 17),
                tableHeaderColumn('Acciones', 17),
              ],
              rows: List.generate(orderListItems.length, (index) {
                final orderListItem = orderListItems[index];
                return _customListTile(orderListItem: orderListItem);
              }),
            ),
          )
        ],
      ),
    );
  }
}

material.DataRow _customListTile({required Order orderListItem}) {
  return material.DataRow(cells: [
    material.DataCell(Text(orderListItem.cantidad.toString())),
    material.DataCell(Text(orderListItem.descripcion)),
    material.DataCell(Text(orderListItem.numeroEnvase)),
    material.DataCell(Text(orderListItem.propietario)),
    material.DataCell(Text(orderListItem.lote)),
    material.DataCell(Text(orderListItem.fechaVen)),
    material.DataCell(Text(orderListItem.valorUnitario.toString())),
    const material.DataCell(Text("Editar")),
  ]);
}
