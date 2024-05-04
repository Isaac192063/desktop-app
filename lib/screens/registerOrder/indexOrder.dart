import 'dart:ui';

import 'package:desktop_app/api/models/Order_model.dart';
import 'package:desktop_app/components/search_bar.dart';
import 'package:desktop_app/components/table.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class IndexOrder extends StatefulWidget {
  const IndexOrder({super.key});

  @override
  State<IndexOrder> createState() => _IndexOrderState();
}

class _IndexOrderState extends State<IndexOrder> {
  @override
  Widget build(BuildContext context) {
    return fluent_ui.ScaffoldPage(
        header: fluent_ui.Column(
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
        content: fluent_ui.Container(
          width: double.infinity,
          child: DataTable(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            columns: [
              DataColumn(label: fluent_ui.Flexible(child:textModified('Cantidad', 17),)),
              DataColumn(label: fluent_ui.Flexible(child:textModified('Descripcion', 17))),
              DataColumn(label: fluent_ui.Flexible(child:textModified('Numero envase', 17))),
              DataColumn(label: fluent_ui.Flexible(child:textModified('propietario', 17))),
              DataColumn(label: fluent_ui.Flexible(child:textModified('lote', 17))),
              DataColumn(label: fluent_ui.Flexible(child:textModified('Fecha ven', 17))),
              DataColumn(label: fluent_ui.Flexible(child:textModified('Valor unit', 17))),
            ],
            rows: List.generate(orderListItems.length, (index) {
              final orderListItem = orderListItems[index];
              return _customListTile(orderListItem: orderListItem);
            }),
          ),
        ));
  }
}

DataRow _customListTile({required Order orderListItem}) {
  return DataRow(cells: [
    DataCell(fluent_ui.Flexible(child: Text(orderListItem.cantidad.toString()))),
    DataCell(fluent_ui.Flexible(child: Text(orderListItem.descripcion))),
    DataCell(fluent_ui.Flexible(child: Text(orderListItem.numeroEnvase))),
    DataCell(fluent_ui.Flexible(child: Text(orderListItem.propietario),)),
    DataCell(fluent_ui.Flexible(child: Text(orderListItem.lote),)),
    DataCell(fluent_ui.Flexible(child: Text(orderListItem.fechaVen),)),
    DataCell(fluent_ui.Flexible(child: Text(orderListItem.valorUnitario.toString()),)),
  ]);
}


