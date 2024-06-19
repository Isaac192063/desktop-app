import 'package:desktop_app/domain/models/Kardex_model.dart';
import 'package:desktop_app/gui/screens/orders/show_order.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/search_bar.dart';
import 'package:desktop_app/gui/widgets/table.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

class IndexKardex extends StatefulWidget {
  const IndexKardex({super.key});

  @override
  State<IndexKardex> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<IndexKardex> {
  List<String> headTile = [
    "Posesion",
    "Fecha de remision",
    "Factura de remision",
    "Envase",
    "Factura de recepcion",
    "Fecha de recepcion",
    "Direccion",
    "Accciones",
  ];
  List<String> content = [
    "juan",
    "2/feb/24",
    "5",
    "6A248",
    "Sin entregar",
    "Sin entregar",
    "Sin entregar",
    "0",
  ];

  @override
  Widget build(BuildContext context) {
    return fluent_ui.ScaffoldPage(
        header: Column(
          children: [
            const Searchbar(),
            Container(
              color: MyColor.btnColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Registro del kardex",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: fluent_ui.Align(
          alignment: Alignment.topCenter,
          child: fluent_ui.SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: fluent_ui.SingleChildScrollView(
              child: fluent_ui.SizedBox(
                width: 990,
                child: DataTable(
                  columnSpacing: 10,
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
                    tableHeaderColumn('Fecha de remision', 17),
                    tableHeaderColumn('Factura de remision', 17),
                    tableHeaderColumn('Numero envase', 17),
                    tableHeaderColumn('Fecha de recepcion', 17),
                    tableHeaderColumn('Factura de recepcion', 17),
                    tableHeaderColumn('Direccion', 17),
                    tableHeaderColumn('Acciones', 17),
                  ],
                  rows: List.generate(kardexListItems.length, (index) {
                    final kardexListItem = kardexListItems[index];
                    return _customListTile(
                        kardexListItem: kardexListItem, context: context);
                  }),
                ),
              ),
            ),
          ),
        ));
  }

  DataRow _customListTile({
    required KardexModel kardexListItem,
    required context,
  }) {
    return DataRow(cells: [
      DataCell(Text(kardexListItem.nombreCliente)),
      DataCell(Text(kardexListItem.fechaRemision)),
      DataCell(Text(kardexListItem.facturaRemision)),
      DataCell(Text(kardexListItem.envaseId)),
      DataCell(Text(kardexListItem.fechaRecepcion ?? "No recibido")),
      DataCell(Text(kardexListItem.facturaRecepcion ?? "No recibido")),
      DataCell(Text(kardexListItem.direccion)),
      DataCell(
        fluent_ui.Row(
          children: [
            IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.green;
                      }
                      return Colors.white;
                    },
                  ),
                ),
                icon: const Icon(fluent_ui.FluentIcons.red_eye, size: 15),
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
}
