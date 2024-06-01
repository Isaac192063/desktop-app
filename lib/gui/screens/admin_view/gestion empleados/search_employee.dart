import 'dart:async';
import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/domain/service/user_service.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchEmployee extends StatefulWidget {
  const SearchEmployee({super.key});

  @override
  State<SearchEmployee> createState() => _SearchEmployeeState();
}

class _SearchEmployeeState extends State<SearchEmployee> {
  final UserService _prov = UserService();
  final TextEditingController _searchController = TextEditingController();
  List<User> listEmployees = [];
  final Debouncer _debouncer = Debouncer(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  void fetchEmployees([String? query]) async {
    // setState(() {
    //   _isLoading = true;
    // });
    print(query);

    if (query?.trim() == "") {
      List<User> aux = await _prov.findByUserName(_searchController.text);
      setState(() {
        listEmployees = aux;
      });
    } else {
      ResponseApi api = await _prov.getAllEmployes();
      List aux = api.data;
      List<User> aux2 = aux.map((e) => User.fromJson(e)).toList();
      setState(() {
        listEmployees = aux2;
      });
    }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSuggestBox<User?>(
            onChanged: (text, reason) {
              _debouncer.run(() {
                fetchEmployees(text);
              });
            },
            style: TextStyle(fontSize: 16),
            controller: _searchController,
            placeholder: "Buscar empleado",
            leadingIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(FluentIcons.search),
            ),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 252, 255, 254)),
            items: listEmployees.map((employee) {
              return AutoSuggestBoxItem<User>(
                  value: employee, label: employee.name);
            }).toList(),
            onSelected: (value) {
              detalleEmployee(context, value.value!);
            },
          ),
        ],
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
