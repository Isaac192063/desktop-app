import 'dart:ui';

import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:desktop_app/domain/providers/customers_provider.dart';
import 'package:desktop_app/domain/service/customer_service.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:desktop_app/gui/screens/customer/customerController.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CreateCustomer extends fluent_ui.StatefulWidget {
  final CustomerController controller;
  const CreateCustomer({super.key, required this.controller});

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends fluent_ui.State<CreateCustomer> {
  late final CustomerController _customerController;
  final CustomerService _customerService = CustomerService();
  late Future<List<City>> _listCities;
  final _formKey = GlobalKey<FormState>();
  List<String> typePersonList = ["NATURAL", "JURIDICO"];
  String? selectedTypePerson = "NATURAL";
  String? cityError;
  String? dateError;
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
    resetControllers();
  }

  @override
  fluent_ui.Widget build(fluent_ui.BuildContext context) {
    return Scaffold(
      body: fluent_ui.SingleChildScrollView(
        child: fluent_ui.Form(
          key: _formKey,
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
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.idController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La cedula es requerida';
                    }
                    return null;
                  },
                ),
              ),
              fluent_ui.ListTile(
                title: const fluent_ui.Row(
                  children: [
                    Icon(Icons.perm_identity),
                    Text("Primer nombre"),
                  ],
                ),
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El primer nombre es requerido';
                    }
                    return null;
                  },
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
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El primer apellido es requerido';
                    }
                    return null;
                  },
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
                    // _customerController.birthDateController.text = '${time.day}/${time.month}/${time.year}';
                    _customerController.birthDateController.text = time.toString();
                        
                    print(_customerController.birthDateController.text);
                    selectedDateTime = time;
                    dateError = null;
                  }),
                ),
              ),
              if (dateError != null)
                fluent_ui.Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    dateError!,
                    style: const TextStyle(
                        color: fluent_ui.Color.fromARGB(255, 145, 17, 8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
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
              if (cityError != null)
                fluent_ui.Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    cityError!,
                    style: const TextStyle(
                        color: fluent_ui.Color.fromARGB(255, 145, 17, 8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              fluent_ui.ListTile(
                title: const fluent_ui.Row(
                  children: [
                    Icon(Icons.my_location),
                    Text("Direccion"),
                  ],
                ),
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La direccion es requerida';
                    }
                    return null;
                  },
                ),
              ),
              fluent_ui.ListTile(
                title: const fluent_ui.Row(
                  children: [
                    Icon(Icons.my_location),
                    Text("Barrio"),
                  ],
                ),
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.neighborhoodController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El barrio es requerido';
                    }
                    return null;
                  },
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
                  child: fluent_ui.ComboBox<String>(
                    value: selectedTypePerson,
                    items: typePersonList.map((e) {
                      return fluent_ui.ComboBoxItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (typePerson) {
                      setState(() => selectedTypePerson = typePerson);
                      print(typePerson);
                      _customerController.typePersonController.text =
                          typePerson!;
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
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.warrantyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'la garantia es requerida';
                    }
                    return null;
                  },
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
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El correo es requerido';
                    }
                    return null;
                  },
                ),
              ),
              fluent_ui.ListTile(
                title: const fluent_ui.Row(
                  children: [Icon(Icons.phone), Text("Telefono")],
                ),
                subtitle: fluent_ui.TextFormBox(
                  controller: _customerController.phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El numero de telefono es requerido';
                    }
                    return null;
                  },
                ),
              ),
              const fluent_ui.SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
      bottomSheet: fluent_ui.Row(
        mainAxisAlignment: fluent_ui.MainAxisAlignment.center,
        children: [
          button(context, "Guardar", () async {
            _validateCity();
            _validateDate();
            if (_formKey.currentState!.validate() &&
                _validateCity() &&
                _validateDate()) {
              await _customerController.registerCustomer();
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.pop(context);
                context.read<CustomersProvider>().setCustomers();
                notification(context, "Cliente añadido con exito", "Success",
                    fluent_ui.InfoBarSeverity.success);
              });
            }
          }, MyColor.btnAcep),
          const SizedBox(
            width: 5,
          ),
          button(
              context,
              "Cancelar",
              () => Navigator.pop(context, 'User canceled dialog'),
              MyColor.btnCancel)
        ],
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
            controller: _customerController.ctyTextController,
            placeholder: 'Seleccione una ciudad',
            items: listCity.map((city) {
              return fluent_ui.AutoSuggestBoxItem<String>(
                value: city.name,
                label: city.name!,
                onSelected: () {
                  _customerController.ctyIdController.text = city.id!;
                  _customerController.dptIdController.text = city.dptId!;
                  setState(() {
                    cityError = null;
                  });
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

  bool _validateCity() {
    print("hola");

    setState(() {
      cityError = _customerController.ctyIdController.text.isEmpty
          ? 'La ciudad es requerida'
          : null;
    });
    return cityError == null;
  }

  bool _validateDate() {
    setState(() {
      dateError = _customerController.birthDateController.text.isEmpty
        ? 'La fecha de nacimiento es requerida'
        : null;
    });
    return dateError == null;
  }

  void resetControllers() {
    _customerController.idController.text = '';
    _customerController.firstNameController.text = '';
    _customerController.middleNameController.text = '';
    _customerController.lastNameController.text = '';
    _customerController.lastName2Controller.text = '';
    _customerController.emailController.text = '';
    _customerController.phoneController.text = '';
    _customerController.addressController.text = '';
    _customerController.neighborhoodController.text = '';
    _customerController.warrantyController.text = '';
    _customerController.typePersonController.text = 'NATURAL';
    _customerController.ctyIdController.text = '';
    _customerController.ctyTextController.text = '';
    _customerController.dptIdController.text = '';
    _customerController.birthDateController.text = '';
  }
}

dynamic createCustomerDialog(
    BuildContext context, CustomerController customerController) async {
  // ignore: unused_local_variable
  final result = await showDialog<String>(
    context: context,
    builder: (context) => fluent_ui.ContentDialog(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 800),
      title: const Text("Agregar cliente"),
      content: CreateCustomer(controller: customerController),
    ),
  );
}
