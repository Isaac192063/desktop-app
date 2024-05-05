import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/domain/providers/employess_provider.dart';
import 'package:desktop_app/domain/service/user_service.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/registerEmploye/registerEmployee.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/registerEmploye/registeremployeeController.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Widget button(context, String text, Function execute, Color color) {
  return FilledButton(
      child: Text(text),
      onPressed: () {
        execute();
      },
      style: ButtonStyle(
          backgroundColor: ButtonState.all(color),
          padding: ButtonState.all(EdgeInsets.all(8)),
          textStyle: ButtonState.all(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))));
}

void detalleEmployee(context, User user) async {
  RegisterEmployeeController con = RegisterEmployeeController(user: user);

  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
      title: const Text('Detalles del empleado'),
      content: viewInformation(context, user),
      actions: [
        button(
            context,
            "Editar",
            () => EditRegisterEmp(context, con, "Editar empleado"),
            Color.fromARGB(255, 63, 89, 194)),
        button(
            context,
            "Cancelar",
            () => Navigator.pop(context, 'User canceled dialog'),
            Color.fromARGB(255, 218, 20, 20))
      ],
    ),
  );
}

Widget viewInformation(BuildContext context, User user) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(directionImage(user.image)),
            radius: 80,
          ),
          Column(
            children: [
              textModified("${user.name} ${user.lastName}", 24),
              textModified(user.email, 20),
              FilledButton(
                  child: user.enabled
                      ? textModified("inhabilitar", 16)
                      : textModified("habilitar", 16),
                  onPressed: () async {
                    ResponseApi res = await UserService()
                        .toggleEmploye(user.idEmployee.toString());

                    context.read<EmployeesProvider>().setEmployees();

                    if (res.success == true) {
                      notification(context, "Empleado inhabilitado", "success",
                          InfoBarSeverity.success);
                    } else {
                      notification(context, "Error al registrar al empleado",
                          "error", InfoBarSeverity.error);
                    }
                    Navigator.pop(context);
                  })
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
        child: Row(
          children: [
            textModified("telefono: ", 15),
            textModified(user.phoneNumber, 15),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
        child: Row(
          children: [
            textModified("fecha de ingreso: ", 15),
            textModified(DateFormat("yyyy-MM-dd").format(user.initialData), 15),
          ],
        ),
      ),
    ],
  );
}

void EditRegisterEmp(
    context, RegisterEmployeeController con, String description) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxHeight: 700, maxWidth: 500),
      title: Text(description),
      content: ResgisterEmployee(con),
      actions: [
        Button(
          child: const Text('Agregar'),
          onPressed: () {
            con.register();
            // Future.delayed(const Duration(milliseconds: 2000), () {
            // dataInit();

            // });
          },
        ),
        FilledButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context, 'User canceled dialog'),
        ),
      ],
    ),
  );
}
