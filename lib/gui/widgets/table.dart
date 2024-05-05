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

Widget employessTbale(List<User> _users, context) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    child: DataTable(
      checkboxHorizontalMargin: 40,
      dataRowHeight: 80,
      columns: [
        DataColumn(label: textModified('Nombre Empleado', 20)),
        DataColumn(label: textModified('Fecha inical', 20)),
        DataColumn(label: textModified('correo', 20)),
        DataColumn(label: textModified('telefono', 20)),
      ],
      rows: _users
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
