import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/domain/providers/employess_provider.dart';
import 'package:desktop_app/domain/service/user_service.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/button_customize.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:desktop_app/gui/screens/admin_view/employees/registerEmploye/registerEmployee.dart';
import 'package:desktop_app/gui/screens/admin_view/employees/registerEmploye/registeremployeeController.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as m;

void detalleEmployee(context, User user) async {
  RegisterEmployeeController con = RegisterEmployeeController(user: user);

  await m.showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxHeight: 550, maxWidth: 500),
      title: const Text('Detalles del empleado'),
      content: viewInformation(context, user),
      actions: [
        buttonCustomize(
            context: context,
            text: "Editar",
            execute: () => EditRegisterEmp(context, con, "Editar empleado"),
            color: MyColor.btnAcep),
        buttonCustomize(
            context: context,
            text: "Cancelar",
            execute: () => Navigator.pop(context, 'User canceled dialog'),
            color: MyColor.btnCancel)
      ],
    ),
  );
}

setEstateEmployee(BuildContext context, String id) async {
  ResponseApi res = await UserService().toggleEmploye(id);

  context.read<EmployeesProvider>().setEmployees();

  if (res.success == true) {
    notification(
        context, "Empleado inhabilitado", "success", InfoBarSeverity.success);
  } else {
    notification(context, "Error al registrar al empleado", "error",
        InfoBarSeverity.error);
  }
  Navigator.pop(context);
}

Widget viewInformation(context, User user) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: MyColor.primaryKey,
          padding: const EdgeInsetsDirectional.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 81,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(directionImage(user.image)),
                  radius: 80,
                ),
              ),
              Row(
                children: [
                  FilledButton(
                      child: user.enabled
                          ? textModified("inhabilitar", 16)
                          : textModified("habilitar", 16),
                      onPressed: () {
                        setEstateEmployee(context, user.id.toString());
                      }),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      FluentIcons.create_mail_rule,
                      size: 30,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        textModified("${user.name} ${user.lastName}", 28),
        textModified(user.email, 16,
            color: const Color.fromARGB(255, 123, 123, 123)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              textModified("cel:  ", 18),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(FluentIcons.phone),
              ),
              textModified("+57 ${user.phoneNumber}", 18),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              textModified("Fecha: ", 18),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(FluentIcons.event_date),
              ),
              textModified(
                  " ${DateFormat("yyyy-MM-dd").format(user.initialData)}", 18),
            ],
          ),
        ),
      ],
    ),
  );
}

void EditRegisterEmp(
    context, RegisterEmployeeController con, String description) async {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  await m.showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxHeight: 750, maxWidth: 500),
      title: Text(description),
      content: ResgisterEmployee(con, _formKey),
      actions: [
        buttonCustomize(
            context: context,
            text: description,
            execute: () {
              if (_formKey.currentState!.validate()) {
                con.register();
              }
            },
            color: MyColor.btnAcep),
        buttonCustomize(
            context: context,
            text: "cancelar",
            execute: () => Navigator.pop(context, 'User canceled dialog'),
            color: MyColor.btnCancel),
      ],
    ),
  );
}
