import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:desktop_app/domain/service/customer_service.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:desktop_app/gui/screens/customer/customerController.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';


class CreateCustomer extends fluent_ui.StatefulWidget {
  final CustomerController controller;
  const CreateCustomer({super.key,required this.controller});

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends fluent_ui.State<CreateCustomer> {
  late final CustomerController _customerController;
  final CustomerService _customerService = CustomerService();
  late Future<List<City>> _listCities;
  List<String> typePersonList = ["NATURAL","JURIDICO"];
  String? selectedTypePerson = "NATURAL";
  City? city;
  DateTime? selectedDateTime;

  bool disabledCity = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listCities = _customerService.getAllCities();
    _customerController = widget.controller;
    _customerController.typePersonController.text = selectedTypePerson!;
  }

  @override
  fluent_ui.Widget build(fluent_ui.BuildContext context) {
    return fluent_ui.ScaffoldPage(
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
              subtitle: fluent_ui.TextBox(
                controller: _customerController.idController,
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Primer nombre"),
                ],
              ),
              
              subtitle: fluent_ui.TextBox(
                controller: _customerController.firstNameController,
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Segundo nombre(opcional)"),
                ],
              ),
              
              subtitle: fluent_ui.TextBox(
                controller: _customerController.middleNameController,
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Primer apellido"),
                ],
              ),
              subtitle: fluent_ui.TextBox(
                controller: _customerController.lastNameController,
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.perm_identity),
                  Text("Segundo apellido(Opcional)"),
                ],
              ),
              subtitle: fluent_ui.TextBox(
                controller: _customerController.lastName2Controller,
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.date_range),
                  Text("Fecha de nacimiento"),
                ],
              ),
              subtitle: fluent_ui.DatePicker(
              selected: selectedDateTime,
              headerStyle: const TextStyle(fontSize: 18),
              contentPadding: const EdgeInsets.all(5),
              onChanged: (time) => setState(() {
                _customerController.birthDateController.text = time.toString();
                print(_customerController.birthDateController.text);
                selectedDateTime = time;
              }),
            ),
            ),
            
            fluent_ui.ListTile(
                title: const fluent_ui.Row(
                  children: [
                    Icon(Icons.location_on),
                    Text("Ciudad"),
                  ],
                ),
                subtitle: searchCity(_listCities)),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.my_location),
                  Text("Direccion"),
                ],
              ),
              subtitle: fluent_ui.TextBox(
                controller: _customerController.addressController,
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.my_location),
                  Text("Barrio"),
                ],
              ),
              subtitle: fluent_ui.TextBox(
                controller: _customerController.neighborhoodController,
              ),
            ),
            fluent_ui.Padding(
              padding: const EdgeInsets.all(8.0),
              child: textModified("Informacion de empresa", 18),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.balance),
                  Text("Tipo de persona"),
                ],
              ),
              subtitle: fluent_ui.SizedBox(
                width: 200,
                child: fluent_ui.ComboBox<String>(
                  value: selectedTypePerson,
                  items: typePersonList.map((e) {
                    return fluent_ui.ComboBoxItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (typePerson){ 
                    setState(() => selectedTypePerson = typePerson);
                    print(typePerson);
                    _customerController.typePersonController.text = typePerson!;
                    
                  },
                ),
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [
                  Icon(Icons.wallet),
                  Text("Garantia"),
                ],
              ),
              subtitle: fluent_ui.TextBox(
                controller: _customerController.warrantyController,
              ),
            ),
            fluent_ui.Padding(
              padding: const EdgeInsets.all(8.0),
              child: textModified("Contacto", 18),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [Icon(Icons.email), Text("Correo")],
              ),
              subtitle: fluent_ui.TextBox(
                controller: _customerController.emailController,
              ),
            ),
            fluent_ui.ListTile(
              title: const fluent_ui.Row(
                children: [Icon(Icons.phone), Text("Telefono")],
              ),
              subtitle: fluent_ui.TextBox(
                controller: _customerController.phoneController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchCity(Future<List<City>> listCities) {
    return FutureBuilder(
      future: listCities,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<City> listCity = snapshot.data!;
          return fluent_ui.AutoSuggestBox<String>(
            placeholder: 'Seleccione una ciudad',
            items: listCity.map((city) {
              return fluent_ui.AutoSuggestBoxItem<String>(
                value: city.name,
                label: city.name!,
                onSelected: (){
                  _customerController.ctyIdController.text = city.id!;
                  _customerController.dptIdController.text = city.dptId!;
                  print(city.id!);
                  print(city.dptId!);
                  setState(() {});
                },
                onFocusChange: (focused) {
                  if (focused) {
                    debugPrint('Focused $city');
                  }
                },
              );
            }).toList(),
           
          );
        }

        return const fluent_ui.ProgressRing();
      },
    );
  }

 

}

 dynamic createCustomerDialog(BuildContext context, CustomerController customerController) async {
  // ignore: unused_local_variable
  final result = await showDialog<String>(
    context: context,
    builder: (context) => fluent_ui.ContentDialog(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 800),
      title: const Text("Agregar cliente"),
      content: CreateCustomer(controller: customerController),
      actions: [
        button(context, "Guardar", () {
          customerController.registerCustomer();
          Navigator.pop(context);
          notification(context, "Cliente añadido con exito", "Success", fluent_ui.InfoBarSeverity.success);
        }, MyColor.btnAcep),
        button(
            context,
            "Cancelar",
            () => Navigator.pop(context, 'User canceled dialog'),
            MyColor.btnCancel)
      ],
    ),
  );
}


