import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:desktop_app/domain/providers/customers_provider.dart';
import 'package:desktop_app/domain/service/customer_service.dart';
import 'package:desktop_app/gui/screens/customer/customerController.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/button_customize.dart';
import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCustomer extends fluent_ui.StatefulWidget {
  final CustomerController controller;
  final Customer customer;
  const EditCustomer(
      {super.key, required this.controller, required this.customer});

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends fluent_ui.State<EditCustomer> {
  late final CustomerController _customerController;
  late final Customer customer;
  final CustomerService _customerService = CustomerService();
  final _formKey = GlobalKey<FormState>();
  late Future<List<City>> _listCities;
  List<String> typePersonList = ["NATURAL", "JURIDICO"];
  String? selectedTypePerson = "NATURAL";
  String? cityError;
  String? dateError;
  City? city;
  DateTime? selectedDateTime;
  bool disabledCity = false;
  @override
  void initState() {
    super.initState();
    _listCities = _customerService.getAllCities();
    _customerController = widget.controller;

    _customerController.idController.text = widget.customer.identification!;
    _customerController.firstNameController.text = widget.customer.firstName!;
    _customerController.middleNameController.text = widget.customer.middleName!;
    _customerController.lastNameController.text = widget.customer.lastName!;
    _customerController.lastName2Controller.text = widget.customer.lastName2!;
    _customerController.emailController.text = widget.customer.email!;
    _customerController.phoneController.text = widget.customer.phoneNumber!;
    _customerController.addressController.text = widget.customer.address!;
    _customerController.neighborhoodController.text =
        widget.customer.neighborhood!;
    _customerController.warrantyController.text = widget.customer.warranty!;
    _customerController.typePersonController.text = widget.customer.typePerson!;
    _customerController.ctyIdController.text = widget.customer.ctyId!;
    _customerController.ctyTextController.text = widget.customer.city!.name!;

    _customerController.dptIdController.text = widget.customer.dptCtyId!;
    _customerController.birthDateController.text = widget.customer.birthDate!;

    selectedTypePerson = widget.customer.typePerson;
    selectedDateTime = DateTime.parse(widget.customer.birthDate!);
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
                  enabled: false,
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
                    _customerController.birthDateController.text =
                        time.toString();

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
        mainAxisAlignment: fluent_ui.MainAxisAlignment.spaceAround,
        children: [
          buttonCustomize(
              context: context,
              text: "Guardar",
              execute: () async {
                _validateCity();
                _validateDate();
                if (_formKey.currentState!.validate() &&
                    _validateCity() &&
                    _validateDate()) {
                  await _customerController.editCustomer();

                  Future.delayed(const Duration(milliseconds: 200), () {
                    context.read<CustomersProvider>().setCustomers();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    notification(context, "Cliente editado con exito",
                        "Success", fluent_ui.InfoBarSeverity.success);
                  });
                }
              },
              pad: 80,
              color: MyColor.btnAcep),
          const SizedBox(
            width: 5,
          ),
          buttonCustomize(
              context: context,
              text: "Cancelar",
              pad: 80,
              execute: () => Navigator.pop(context, 'User canceled dialog'),
              color: MyColor.btnCancel)
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
}

dynamic editCustomer(BuildContext context, Customer customerListItem,
    CustomerController customerController) async {
  // ignore: unused_local_variable
  final result = await showDialog<String>(
    context: context,
    builder: (context) => fluent_ui.ContentDialog(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 800),
      title: const Text("Editar el cliente"),
      content: EditCustomer(
          controller: customerController, customer: customerListItem),
    ),
  );
}
