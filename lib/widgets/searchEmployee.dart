import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/api/user_provider.dart';
import 'package:desktop_app/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class SearchEmployee extends StatefulWidget {
  const SearchEmployee({super.key});

  @override
  State<SearchEmployee> createState() => _SearchEmployeeState();
}

class _SearchEmployeeState extends State<SearchEmployee> {
  final UserProvider _prov = UserProvider();
  List<User> employess = [];

  void searchEmpServer(String name) async {
    List<User> usrsFind = await compute(_prov.findByUserName, name);
    setState(() {
      employess = usrsFind;
    });
  }

  Widget searchEmployee(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width / 2,
      child: AutoSuggestBox<User>(
        onChanged: (text, reason) {
          searchEmpServer(text);
        },
        style: TextStyle(fontSize: 16),
        placeholder: "Buscar empleado",
        leadingIcon: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(FluentIcons.search),
        ),
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 252, 255, 254)),
        items: employess.map((employee) {
          return AutoSuggestBoxItem<User>(
              value: employee, label: employee.name);
        }).toList(),
        onSelected: (value) {
          detalleEmployee(context, value.value!);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: searchEmployee(context));
  }
}
