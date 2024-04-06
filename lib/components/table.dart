import 'package:flutter/material.dart';

dynamic rowModified(List<String> product, bool styleTitle) {
  return TableRow(
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(width: 0.8, color: Colors.grey),
      ),
    ),
    children: List.generate(
      product.length,
      (index) => TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Material(
          child: InkWell(
            onTap: () {
              print(product[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                product[index],
                style: TextStyle(
                  fontWeight: styleTitle ? FontWeight.bold : null,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget table(BuildContext context, int numberRows, List<String> header,
    List<String> content) {
  return Center(
      child: Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      rowModified(header, true),
      ...List.generate(numberRows, (index) => rowModified(content, false))
    ],
  ));
}
