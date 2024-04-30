import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/widgets/setImgae.dart';
import 'package:desktop_app/screens/admin_view/gestion%20empleados/registerEmploye/registerEmployee.dart';
import 'package:desktop_app/screens/admin_view/gestion%20empleados/registerEmploye/registeremployeeController.dart';
import 'package:desktop_app/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

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
              TextStyle(fontSize: 16, fontWeight: FontWeight.w500))));
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
            () => showContentDialogEdit(context, con, "Editar empleado"),
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

Widget viewInformation(context, User user) {
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

void showContentDialogEdit(BuildContext context,
    RegisterEmployeeController _con, String description) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: BoxConstraints(maxHeight: 700, maxWidth: 500),
      title: Text(description),
      content: ResgisterEmployee(_con),
      actions: [
        Button(
          child: const Text('Agregar'),
          onPressed: () async {
            _con.register();
            Navigator.pop(context, 'User deleted file');
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
