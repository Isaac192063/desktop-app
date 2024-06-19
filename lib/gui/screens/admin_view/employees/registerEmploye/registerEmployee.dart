import 'dart:io';
import 'package:desktop_app/gui/screens/admin_view/employees/registerEmploye/registeremployeeController.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/input.dart';
import 'package:desktop_app/gui/widgets/inputPassword.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_validator/email_validator.dart';

class ResgisterEmployee extends StatefulWidget {
  final RegisterEmployeeController con;
  final GlobalKey<FormState> formKey;
  const ResgisterEmployee(this.con, this.formKey, {super.key});

  @override
  State<ResgisterEmployee> createState() => _MyAppState();
}

class _MyAppState extends State<ResgisterEmployee> {
  RegisterEmployeeController? _con;
  GlobalKey<FormState>? _formKey;
  File? images;
  String? im;

  @override
  void initState() {
    super.initState();
    setState(() {
      _con = widget.con;
      _con!.init(context);
      im = _con?.user?.image;
      _formKey = widget.formKey;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomInput(
                    label: 'Nombre',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su nombre';
                      }
                      return null;
                    },
                    icon: Icon(Icons.person),
                    controller: _con!.nameController,
                  ),
                  CustomInput(
                    label: 'Apellido',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su Apellido';
                      }
                      return null;
                    },
                    icon: Icon(Icons.person_3_sharp),
                    controller: _con!.lastNameController,
                  ),
                  CustomInput(
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su Email';
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Por favor ingrese un email valido";
                      }
                      return null;
                    },
                    icon: Icon(Icons.email),
                    controller: _con!.emailController,
                  ),
                  CustomPasswordInput(
                    label: 'Contraseña',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }

                      if (value.length < 6) {
                        return "La contraseña debe tener minimo 6 caracteres";
                      }
                      return null;
                    },
                    icon: Icon(Icons.person),
                    controller: _con!.passwordController,
                  ),
                  CustomInput(
                    label: 'Telefono',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su telefono';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Por favor ingrese solo números';
                      }
                      return null;
                    },
                    icon: Icon(Icons.phone),
                    controller: _con!.numberPhoneController,
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
      debugPrint(result.path);
    } else {
      setState(() {
        images = file2;
      });
    }
  }
}
