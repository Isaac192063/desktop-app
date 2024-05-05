import 'dart:io';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/registerEmploye/registeremployeeController.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';

class ResgisterEmployee extends StatefulWidget {
  final RegisterEmployeeController con;
  const ResgisterEmployee(this.con, {super.key});

  @override
  State<ResgisterEmployee> createState() => _MyAppState();
}

class _MyAppState extends State<ResgisterEmployee> {
  RegisterEmployeeController? _con;

  File? images;
  String? im;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _con = widget.con;
      _con!.init(context);
      im = _con?.user?.image;
    });
  }

  Widget imageLocal() {
    if (images != null) {
      return Stack(alignment: Alignment.center, children: [
        Image.file(
          images!,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        Text(
          "click para cambiar la imagen",
          softWrap: true,
          style: TextStyle(color: MyColor.white),
        )
      ]);
    } else {
      return im == null
          ? Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              color: MyColor.bgOrder,
              child: const Text("seleccionar la imagen"),
            )
          : Stack(alignment: Alignment.center, children: [
              Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(directionImage(im!)),
                      fit: BoxFit.cover,
                    ),
                  )),
              Text(
                "click para cambiar la imagen",
                softWrap: true,
                style: TextStyle(color: MyColor.white),
              )
            ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        child: Container(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width / 3,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextBox(
                    placeholder: "nombre",
                    controller: _con!.nameController,
                    padding: EdgeInsets.all(10),
                    style: TextStyle(fontSize: 16),
                  ),
                  TextBox(
                    placeholder: "apellido",
                    controller: _con!.lastNameController,
                    padding: EdgeInsets.all(10),
                    style: TextStyle(fontSize: 16),
                  ),
                  TextBox(
                    placeholder: "email",
                    controller: _con!.emailController,
                    padding: EdgeInsets.all(10),
                    style: TextStyle(fontSize: 16),
                  ),
                  PasswordBox(
                    placeholder: "contraseña",
                    controller: _con!.passwordController,
                    padding: EdgeInsets.all(10),
                    style: TextStyle(fontSize: 16),
                  ),
                  TextBox(
                    placeholder: "telefono",
                    controller: _con!.numberPhoneController,
                    padding: EdgeInsets.all(10),
                    style: TextStyle(fontSize: 16),
                  ),
                  Material(
                    child: InkWell(
                      child: imageLocal(),
                      onTap: () {
                        debugPrint("seleccionando imagen");
                        selectImg();
                      },
                    ),
                  ),
                  // FilledButton(
                  //     child: Text("seleccionar imagen"), onPressed: main),
                ]),
          ),
        ),
      ),
    );
  }

  void selectImg() {
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
    _con!.imagen = result;
    if (result != null) {
      print(result.path);
    } else {
      setState(() {
        images = file2;
      });
    }
  }
}
