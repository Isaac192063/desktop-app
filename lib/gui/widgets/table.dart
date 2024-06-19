import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:desktop_app/gui/widgets/productView.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:desktop_app/gui/screens/admin_view/employees/edit_detail_Employee.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: fluent_ui.BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      sortAscending: true,
      showCheckboxColumn: false,
      headingRowColor:
          MaterialStateColor.resolveWith((states) => MyColor.medio),
      border: const fluent_ui.TableBorder(
        horizontalInside: fluent_ui.BorderSide(
          color: fluent_ui.Color.fromARGB(255, 0, 0, 0),
          width: 0.1,
        ),
      ),
      dataRowHeight: 75,
      columns: [
        ...List.generate(
            headers.length,
            (index) =>
                DataColumn(label: textModified(headers[index], 20, bold: true)))
      ],
      rows: users
          .map(
            (user) => DataRow(
              color: user.enabled
                  ? MaterialStateColor.resolveWith((states) => MyColor.white)
                  : MaterialStateColor.resolveWith((states) => MyColor.claro),
              onSelectChanged: (value) {
                detalleEmployee(context, user);
              },
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
                ),
                DataCell(textModified(
                    DateFormat("yyyy-MM-dd").format(user.initialData), 17)),
                DataCell(textModified(user.email, 18)),
                DataCell(
                  textModified(user.phoneNumber, 18),
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
