import 'package:desktop_app/api/models/Order_model.dart';
import 'package:desktop_app/components/search_bar.dart';
import 'package:desktop_app/components/table.dart';
import 'package:desktop_app/screens/registerOrder/order_template.dart';
import 'package:desktop_app/screens/registerOrder/registerOrder.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

class IndexOrder extends StatefulWidget {
  const IndexOrder({Key? key}) : super(key: key);

  @override
  State<IndexOrder> createState() => _IndexOrderState();
}

class _IndexOrderState extends State<IndexOrder> {
  @override
  Widget build(BuildContext context) {
    return fluent_ui.ScaffoldPage(
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
        ],
      ),
      content: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DataTable(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: fluent_ui.BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              columns: [
                tableHeaderColumn('id', 17),
                tableHeaderColumn('fecha de remision', 17),
                tableHeaderColumn('cantidad envases', 17),
                tableHeaderColumn('factura', 17),
                tableHeaderColumn('total', 17),
                tableHeaderColumn('Acciones', 17),
              ],
              rows: List.generate(orderListItems.length, (index) {
                final orderListItem = orderListItems[index];
                return _customListTile(
                    orderListItem: orderListItem, context: context);
              }),
            ),
          )
        ],
      ),
    );
  }
}

DataRow _customListTile({required Order orderListItem, required context}) {
  return DataRow(cells: [
    DataCell(Text(orderListItem.id.toString())),
    DataCell(Text(orderListItem.fechaRemision)),
    DataCell(Text(orderListItem.cantidadEnvases.toString())),
    DataCell(Text(orderListItem.factura)),
    DataCell(Text(orderListItem.total.toString())),
    DataCell(fluent_ui.Row(
      children: [
        IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                },
              ),
            ),
            icon: Icon(fluent_ui.FluentIcons.red_eye, size: 15),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterOrder()),
                )),
                IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.green;
              }
            },
          ),
        ),
        icon: Icon(fluent_ui.FluentIcons.edit_list_pencil, size: 15),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterOrder()),
            )),
      ],
    ),
            ),
  ]);
}
