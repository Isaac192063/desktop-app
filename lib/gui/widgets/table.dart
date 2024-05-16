import 'dart:async';

import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/models/Product_model.dart';
import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:desktop_app/gui/widgets/productView.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void _navigateToNewScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ProductView()));
}

dynamic rowModified(
    List<Product> product, bool styleTitle, BuildContext context) {
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
                product[index].supplier!,
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
    List<Product> content) {
  return Center(
      child: Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      rowModified(content, true, context),
      ...List.generate(
          content.length, (index) => rowModified(content, false, context))
    ],
  ));
}

Widget employessTbale(List<User> users, List<String> headers, context) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    child: DataTable(
      checkboxHorizontalMargin: 40,
      dataRowHeight: 80,
      columns: [
        ...List.generate(headers.length,
            (index) => DataColumn(label: textModified(headers[index], 20)))
      ],
      rows: users
          .map(
            (user) => DataRow(
              color: user.enabled
                  ? MaterialStateColor.resolveWith(
                      (states) => Color.fromARGB(255, 218, 255, 227))
                  : MaterialStateColor.resolveWith(
                      (states) => Color.fromARGB(255, 255, 230, 218)),
              cells: [
                DataCell(
                  Row(
                    children: [
                      setImage(user.image, 25),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: textModified(user.name, 18),
                      )
                    ],
                  ),
                  onTap: () {
                    detalleEmployee(context, user);
                  },
                ),
                DataCell(onTap: () {
                  detalleEmployee(context, user);
                }, Text(DateFormat("yyyy-MM-dd").format(user.initialData))),
                DataCell(Text(user.email), onTap: () {
                  detalleEmployee(context, user);
                }, showEditIcon: true),
                DataCell(
                  Text(user.phoneNumber),
                  onTap: () {
                    detalleEmployee(context, user);
                  },
                ),
              ],
            ),
          )
          .toList(),
    ),
  );
}

DataColumn tableHeaderColumn(String text, double size) {
  return DataColumn(
      label: Flexible(
          child: Wrap(
    children: [
      Text(
        text,
        softWrap: true,
        style: TextStyle(fontSize: size, fontWeight: FontWeight.w600),
      )
    ],
  )));
}

Widget productTable(List<Product> product, List<String> headers, context) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    child: DataTable(
      checkboxHorizontalMargin: 40,
      dataRowHeight: 80,
      columns: [
        ...List.generate(headers.length,
            (index) => DataColumn(label: textModified(headers[index], 20)))
      ],
      rows: product
          .map(
            (user) => DataRow(
              cells: [
                DataCell(Text(user.idPackaging!)),
                DataCell(Text(user.typePackaging!.color!)),
                DataCell(Text(user.typePackaging!.price!.toString())),
              ],
            ),
          )
          .toList(),
    ),
  );
}

class TableProduct extends StatefulWidget {
  final List<Product> prods;
  final List<Product> prodsSelected;
  final Function(Product) notifyParent;

  const TableProduct(this.notifyParent, this.prods, this.prodsSelected,
      {super.key});

  @override
  State<TableProduct> createState() => _nameState();
}

class _nameState extends State<TableProduct> {
  late List<bool> selected;

  late List<Product> listProducts;

  @override
  void initState() {
    super.initState();
    listProducts = widget.prods;
    selected = List<bool>.generate(listProducts.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Serial'),
              ),
              DataColumn(
                label: Text('Tipo de envase'),
              ),
              DataColumn(
                label: Text('Precio'),
              ),
            ],
            rows: List<DataRow>.generate(
              listProducts.length,
              (int index) => DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  }
                  if (index.isEven) {
                    return Colors.grey.withOpacity(0.3);
                  }
                  return null;
                }),
                cells: <DataCell>[
                  DataCell(Text(listProducts[index].idPackaging!)),
                  DataCell(Text(listProducts[index].content!.name!)),
                  DataCell(Text((listProducts[index].typePackaging!.price! +
                          listProducts[index].content!.price!)
                      .toString()))
                ],
                selected: selected[index],
                onSelectChanged: (bool? value) {
                  setState(() {
                    widget.notifyParent(listProducts[index]);
                    selected[index] = value!;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
