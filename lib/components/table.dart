import 'package:desktop_app/components/productView.dart';
import 'package:flutter/material.dart';

void _navigateToNewScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ProductView()));
}

dynamic rowModified(
    List<String> product, bool styleTitle, BuildContext context) {
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
              _navigateToNewScreen(context);
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
      rowModified(header, true, context),
      ...List.generate(
          numberRows, (index) => rowModified(content, false, context))
    ],
  ));
}
