import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:desktop_app/gui/widgets/productView.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void _navigateToNewScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ProductView()));
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
                  ? MaterialStateColor.resolveWith((states) => MyColor.medio)
                  : MaterialStateColor.resolveWith((states) => MyColor.claro),
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
