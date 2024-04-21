import 'package:desktop_app/api/models/User.dart';
import 'package:fluent_ui/fluent_ui.dart';

void showContentDialog(context, User user) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(maxHeight: 700, maxWidth: 500),
      title: const Text('Agregar nuevo Empleado'),
      content: Container(child: Text(user.name)),
      actions: [
        Button(
          child: const Text('Agregar'),
          onPressed: () {
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
