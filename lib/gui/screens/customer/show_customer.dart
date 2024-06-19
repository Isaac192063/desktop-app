import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:desktop_app/domain/providers/customers_provider.dart';
import 'package:desktop_app/domain/service/customer_service.dart';
import 'package:desktop_app/gui/screens/customer/customerController.dart';
import 'package:desktop_app/gui/screens/customer/edit_customer.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

dynamic showDetailCustomer(BuildContext context, Customer customerListItem,
    CustomerController customerController) async {
  // ignore: unused_local_variable
  final result = await showDialog<String>(
    context: context,
    builder: (context) => fluent_ui.ContentDialog(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 800),
      title: Row(
        mainAxisAlignment: fluent_ui.MainAxisAlignment.spaceBetween,
        children: [
          Text(
              "${customerListItem.firstName!}  ${customerListItem.lastName!} ${customerListItem.lastName2} "),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      actions: [
        fluent_ui.FilledButton(
            onPressed: () {
              editCustomer(context, customerListItem, customerController);
            },
            style: fluent_ui.ButtonStyle(
                backgroundColor: fluent_ui.ButtonState.all(MyColor.btnAcep),
                padding: fluent_ui.ButtonState.all(
                    const EdgeInsets.symmetric(vertical: 8)),
                textStyle: fluent_ui.ButtonState.all(const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            child: const Text("Editar")),
        fluent_ui.FilledButton(
            style: fluent_ui.ButtonStyle(
              backgroundColor: fluent_ui.ButtonState.all(MyColor.btnCancel),
              padding: fluent_ui.ButtonState.all(
                  const EdgeInsets.symmetric(vertical: 8)),
            ),
            child: customerListItem.state!
                ? textModified("inhabilitar", 16)
                : textModified("habilitar", 16),
            onPressed: () async {
              await setStateCustomer(context, customerListItem.identification!);

              if (customerListItem.state!) {
                notification(context, "Cliente Inhabilitado", "success",
                    fluent_ui.InfoBarSeverity.success);
              } else {
                notification(context, "Cliente Habilitado", "success",
                    fluent_ui.InfoBarSeverity.success);
              }
            }),
      ],
      content: fluent_ui.SingleChildScrollView(
        child: fluent_ui.Column(
          crossAxisAlignment: fluent_ui.CrossAxisAlignment.start,
          children: [
            fluent_ui.Padding(
              padding: const EdgeInsets.all(8.0),
              child: textModified("Informacion personal", 18),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Cedula"),
                ],
              ),
              subtitle: Text(customerListItem.identification!),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Segundo nombre"),
                ],
              ),
              subtitle: Text(customerListItem.middleName ?? "No tiene"),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Segundo apellido"),
                ],
              ),
              subtitle: Text(customerListItem.lastName2 ?? "No tiene"),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.location_on),
                  Text("Ciudad"),
                ],
              ),
              subtitle: Text(customerListItem.city!.name!),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Fecha de nacimiento"),
                ],
              ),
              subtitle: Text(customerListItem.birthDate!),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.my_location),
                  Text("Direccion"),
                ],
              ),
              subtitle: Text(
                  "Barrio ${customerListItem.neighborhood} ${customerListItem.address}"),
            ),
            fluent_ui.Padding(
              padding: const EdgeInsets.all(8.0),
              child: textModified("Contacto", 18),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [Icon(Icons.email), Text("Correo")],
              ),
              subtitle: Text(customerListItem.email!),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [Icon(Icons.phone), Text("Telefono")],
              ),
              subtitle: Text(customerListItem.phoneNumber!),
            ),
            fluent_ui.Padding(
              padding: const EdgeInsets.all(8.0),
              child: textModified("Datos de empresa", 18),
            ),
            fluent_ui.Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tipo de persona: ${customerListItem.typePerson}"),
            ),
            fluent_ui.Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Garantia: ${customerListItem.warranty}"),
            ),
          ],
        ),
      ),
    ),
  );
}

setStateCustomer(BuildContext context, String id) async {
  ResponseApi res = await CustomerService().toggleCustomer(id);

  context.read<CustomersProvider>().setCustomers();

  if (res.success == true) {
    print("Success");
  } else {
    notification(context, "Error", "error", fluent_ui.InfoBarSeverity.error);
  }
  Navigator.pop(context);
}
