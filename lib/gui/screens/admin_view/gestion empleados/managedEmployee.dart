import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/domain/providers/employess_provider.dart';
import 'package:desktop_app/domain/service/user_service.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:desktop_app/gui/widgets/searchEmployee.dart';
import 'package:desktop_app/gui/widgets/table.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/registerEmploye/registeremployeeController.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class ManageEmployee extends StatefulWidget {
  const ManageEmployee({super.key});

  @override
  State<ManageEmployee> createState() => _ManageEmployeeState();
}

class _ManageEmployeeState extends State<ManageEmployee> {
  final UserService _prov = UserService();
  List<User>? employess = [];
  final RegisterEmployeeController _con = RegisterEmployeeController();
  List<String> headersEmployee = [
    "Nombre Empleado",
    "fecha inicial",
    "correo",
    "telefono"
  ];

  @override
  void initState() {
    super.initState();
    _con.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EmployeesProvider>().setEmployees();
    });
  }

  void searchEmpServer(String name) async {
    List<User> usrsFind = await _prov.findByUserName(name);
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
        placeholder: "Buscar empleado",
        leadingIcon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(FluentIcons.search),
        ),
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 252, 255, 254)),
        items: employess!.map((employee) {
          return AutoSuggestBoxItem<User>(
              value: employee, label: employee.name);
        }).toList(),
        onSelected: (value) {
          detalleEmployee(context, value.value!);
        },
      ),
    );
  }

  Widget dataInProcess() {
    return context.watch<EmployeesProvider>().cargando
        ? const Center(
            child: ProgressRing(),
          )
        : employessTbale(context.watch<EmployeesProvider>().getEmployees,
            headersEmployee, context);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textModified("Lista de Empleados", 25),
                    const SearchEmployee(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(child: dataInProcess()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FilledButton(
                          child: const Text("Agregar nuevo empleado"),
                          onPressed: () {
                            EditRegisterEmp(
                                context, _con, "Registrar nuevo empleado");
                          }),
                    )
                  ]),
            ),
          )),
    );
  }
}
