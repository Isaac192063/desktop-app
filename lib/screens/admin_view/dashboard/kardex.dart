import 'package:desktop_app/screens/admin_view/dashboard/header_widget.dart';
import 'package:flutter/material.dart';

class kardex extends StatefulWidget {
  const kardex({super.key});

  @override
  State<kardex> createState() => _kardexState();
}

class _kardexState extends State<kardex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 227, 227),
      body: Column(
        children: [
          Container(
            color: Colors.teal[500],
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Registro del kardex",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const headerWidget(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
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
          DataTable(
              columnSpacing: 50,
              border: TableBorder(
                  top: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black)),
              columns: const [
                DataColumn(label: Text("Posesion")),
                DataColumn(label: Text("Fecha de remision")),
                DataColumn(label: Text("Factura de remision")),
                DataColumn(label: Text("Envase")),
                DataColumn(label: Text("Factura de recepcion")),
                DataColumn(label: Text("Fecha de recepcion")),
                DataColumn(label: Text("Direccion")),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text("juan")),
                  DataCell(Text("2/feb/24")),
                  DataCell(Text("5")),
                  DataCell(Text("6A248")),
                  DataCell(Text("Sin entregar")),
                  DataCell(Text("Sin entregar")),
                  DataCell(Text("Sin entregar")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Pedro")),
                  DataCell(Text("15/oct/23")),
                  DataCell(Text("4")),
                  DataCell(Text("6A248")),
                  DataCell(Text("4")),
                  DataCell(Text("5/dic/23")),
                  DataCell(Text("Sin entregar")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Antonio")),
                  DataCell(Text("12/ene/23")),
                  DataCell(Text("3")),
                  DataCell(Text("6A248")),
                  DataCell(Text("3")),
                  DataCell(Text("4/abr/23")),
                  DataCell(Text("Sin entregar")),
                ]),
                DataRow(cells: [
                  DataCell(Text("1")),
                  DataCell(Text("1")),
                  DataCell(Text("2")),
                  DataCell(Text("2")),
                  DataCell(Text("2")),
                  DataCell(Text("2")),
                  DataCell(Text("Sin entregar")),
                ]),
              ])
        ],
      ),
    );
  }
}
