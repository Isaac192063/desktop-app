import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:desktop_app/domain/providers/customers_provider.dart';
import 'package:desktop_app/gui/screens/customer/create_customer.dart';
import 'package:desktop_app/gui/screens/customer/customerController.dart';
import 'package:desktop_app/gui/screens/customer/show_customer.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/search_bar.dart';
import 'package:desktop_app/gui/widgets/table.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexCustomer extends StatefulWidget {
  
  const IndexCustomer({Key? key}) : super(key: key);

  @override
  State<IndexCustomer> createState() => _IndexOrderState();
}

class _IndexOrderState extends State<IndexCustomer> {
  final CustomerController _customerController = CustomerController();
  late Future<List<Customer>> listCustomers;
  String? idError;
  String? firstNameError;
  String? lastNameError;
  String? addressError;
  String? neighborhoodError;
  String? emailError;
  String? phoneError;
  bool isRowSelected = false;
  @override
  void initState() {
    super.initState();
    listCustomers = _customerController.getAllCustomers();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CustomersProvider>().setCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.bgOrder,
        appBar: AppBar(
          backgroundColor: MyColor.bgOrder,
          title: const Text("Clientes"),
          bottom: AppBar(
            backgroundColor: MyColor.bgOrder,
            title: const Searchbar(),
            
          ),
        ),
        body: fluent_ui.Padding(
          padding: const EdgeInsets.all(8.0),
          child: fluent_ui.Align(
            alignment: Alignment.topCenter,
            child: fluent_ui.SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: fluent_ui.SingleChildScrollView(
                child: fluent_ui.Column(
                  crossAxisAlignment: fluent_ui.CrossAxisAlignment.start,
                  children: [
                    fluent_ui.FilledButton(
                      child: const Text('Agregar nuevo cliente'),
                      onPressed: () {
                        createCustomerDialog(context, _customerController);
                      },
                    ),
                    const fluent_ui.SizedBox(
                      height: 8,
                    ),
                    fluent_ui.SizedBox(
                        width:
                        fluent_ui.MediaQuery.of(context).size.width / 1.2,
                        child: FutureBuilder<List<Customer>>(
                          future: listCustomers,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: fluent_ui.ProgressRing());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No se encontraron clientes'));
                            }
                            List<Customer> customers =
                                context.watch<CustomersProvider>().getCustomers;
                            return DataTable(
                              sortAscending: true,
                              showCheckboxColumn: false,
                              // ignore: deprecated_member_use
                              dataRowHeight: 40,
                              columnSpacing: 2,
                              border: const fluent_ui.TableBorder(
                                horizontalInside: fluent_ui.BorderSide(
                                  color: Colors.grey,
                                  width: 0.3,
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: fluent_ui.BorderSide(
                                      width: 1, color: Colors.grey),
                                ),
                              ),
                              columns: [
                                tableHeaderColumn('Cedula', 17),
                                tableHeaderColumn('Direccion', 17),
                                tableHeaderColumn('Nombre', 17),
                                tableHeaderColumn('Ciudad', 17),
                                tableHeaderColumn('Estado', 17),
                              ],
                              rows: customers.map((customer) {
                                return _customListTile(
                                    customerListItem: customer,
                                    context: context);
                              }).toList(),
                            );
                          },
                        )),
                    
                    
                  ],
                ),
              ),
            ),
          ),
        ));

        
  }
 

  bool validateForm() {
    bool isValid = true;
    setState(() {
      idError = _customerController.idController.text.isEmpty
          ? 'La cedula es requerida'
          : null;
      firstNameError = _customerController.firstNameController.text.isEmpty
          ? 'El primer nombre es requerido'
          : null;
      lastNameError = _customerController.lastNameController.text.isEmpty
          ? 'El primer apellido es requerido'
          : null;
      addressError = _customerController.addressController.text.isEmpty
          ? 'La direccion es requerida'
          : null;
      neighborhoodError =
          _customerController.neighborhoodController.text.isEmpty
              ? 'El barrio es requerido'
              : null;
      emailError = _customerController.emailController.text.isEmpty
          ? 'El correo es requerido'
          : null;
      phoneError = _customerController.phoneController.text.isEmpty
          ? 'El telefono es requerido'
          : null;

      if (idError != null ||
          firstNameError != null ||
          lastNameError != null ||
          addressError != null ||
          neighborhoodError != null ||
          emailError != null ||
          phoneError != null) {
        isValid = false;
      }
    });
    return isValid;
  }

  DataRow _customListTile({
    required Customer customerListItem,
    required context,
  }) {
    return DataRow(
      onSelectChanged: (value) {
        showDetailCustomer(context, customerListItem, _customerController);
        
      },
      cells: [
        DataCell(Text(customerListItem.identification!)),
        DataCell(Text(customerListItem.address!)),
        DataCell(Text(customerListItem.firstName!)),
        DataCell(Text(customerListItem.city!.name!)),
        DataCell(Text(customerListItem.state! ? "Activo" : "Inactivo")),
      ],
    );
  }


}

