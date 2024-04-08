import 'dart:io';

import 'package:desktop_app/screens/admin_view/registerEmployee/registeremployeeController.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:filepicker_windows/filepicker_windows.dart';

class ResgisterEmployee extends StatefulWidget {
  const ResgisterEmployee({super.key});

  @override
  State<ResgisterEmployee> createState() => _MyAppState();
}

class _MyAppState extends State<ResgisterEmployee> {
  RegisterEmployeeController _con = RegisterEmployeeController();

  File? images;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.init(context);
  }

  Widget imageLocal() {
    if (images != null) {
      return Center(
        child: Image.file(
          images!,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Text("No se seleccionó ninguna imagen.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        child: Container(
          height: MediaQuery.of(context).size.width / 3,
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextBox(
                  placeholder: "nombre",
                  controller: _con.nameController,
                  padding: EdgeInsets.all(10),
                  style: TextStyle(fontSize: 16),
                ),
                TextBox(
                  placeholder: "apellido",
                  controller: _con.lastNameController,
                  padding: EdgeInsets.all(10),
                  style: TextStyle(fontSize: 16),
                ),
                TextBox(
                  placeholder: "email",
                  controller: _con.emailController,
                  padding: EdgeInsets.all(10),
                  style: TextStyle(fontSize: 16),
                ),
                TextBox(
                  placeholder: "contraseña",
                  controller: _con.passwordController,
                  padding: EdgeInsets.all(10),
                  style: TextStyle(fontSize: 16),
                ),
                TextBox(
                  placeholder: "telefono",
                  controller: _con.numberPhoneController,
                  padding: EdgeInsets.all(10),
                  style: TextStyle(fontSize: 16),
                ),
                imageLocal(),
                FilledButton(
                    child: Text("seleccionar imagen"), onPressed: main),
                FilledButton(
                    child: Text("Registrar empleado"),
                    onPressed: _con.register),
              ]),
        ),
      ),
    );
  }

  void main() {
    final file = OpenFilePicker()
      ..filterSpecification = {'All Files': '*.*'}
      ..defaultFilterIndex = 0
      ..defaultExtension = 'doc'
      ..title = 'Select a document';

    File? file2 = images;
    final result = file.getFile();
    setState(() {
      images = result;
    });
    _con.imagen = result;
    if (result != null) {
      print(result.path);
    } else {
      setState(() {
        images = file2;
      });
    }
  }
}
