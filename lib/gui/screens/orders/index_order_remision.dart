
import 'package:desktop_app/domain/models/Order_model.dart';
import 'package:desktop_app/gui/widgets/search_bar.dart';
import 'package:desktop_app/gui/widgets/table.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
class IndexOrderRemision extends StatefulWidget {
  const IndexOrderRemision({Key? key}) : super(key: key);

  @override
  State<IndexOrderRemision> createState() => _IndexOrderState();
}

class _IndexOrderState extends State<IndexOrderRemision> {
  bool isRowSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registro de Remisiones"),
          bottom: AppBar(
            title: const Searchbar(),
          ),
          
        ),
        body: fluent_ui.Align(
          alignment: Alignment.topCenter,
          child: fluent_ui.SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: fluent_ui.SingleChildScrollView(
              child: fluent_ui.SizedBox(
                width: fluent_ui.MediaQuery.of(context).size.width / 1.2,
                child: DataTable(
                  showCheckboxColumn: false,
                  // ignore: deprecated_member_use
                  dataRowHeight: 40,
                  columnSpacing: 2,
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
                      bottom:
                          fluent_ui.BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  columns: [
                    tableHeaderColumn('Cliente', 17),
                    tableHeaderColumn('fecha de Remision', 17),
                    tableHeaderColumn('cantidad envases', 17),
                    tableHeaderColumn('factura', 17),
                    tableHeaderColumn('total', 17),
                  ],
                  rows: List.generate(orderListItems.length, (index) {
                    final orderListItem = orderListItems[index];
                    return _customListTile(
                        orderListItem: orderListItem, context: context);
                  }),
                ),
              ),
            ),
          ),
        ));
  }

  DataRow _customListTile({
    required Order orderListItem,
    required context,
  }) {
    return DataRow(
      onSelectChanged:  (value){

      },
      cells: [
      DataCell(Text(orderListItem.nombreCliente)),
      DataCell(Text(orderListItem.fechaRemision)),
      DataCell(Text(orderListItem.cantidadEnvases.toString())),
      DataCell(Text(orderListItem.factura)),
      DataCell(Text(orderListItem.total.toString())),
    ]);
  }
}