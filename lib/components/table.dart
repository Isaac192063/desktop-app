import 'package:flutter/material.dart';

dynamic as() {
  return TableRow(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1.0, color: Colors.black))),
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text("text 1"),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text("text 1"),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text("text 1"),
          ),
        ),
      ]);
}

Widget table(BuildContext context) {
  return Center(
      child: Table(
    border: TableBorder(
      top: BorderSide(width: 1.0, color: Colors.black),
      bottom: BorderSide.none,
    ),
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [as(), ...List.generate(10, (index) => as())],
  ));
}
