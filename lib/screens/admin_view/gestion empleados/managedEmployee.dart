import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/api/response_api.dart';
import 'package:desktop_app/api/user_provider.dart';
import 'package:desktop_app/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:desktop_app/widgets/searchEmployee.dart';
import 'package:desktop_app/widgets/table.dart';
import 'package:desktop_app/screens/admin_view/gestion%20empleados/registerEmploye/registerEmployee.dart';
import 'package:desktop_app/screens/admin_view/gestion%20empleados/registerEmploye/registeremployeeController.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ManageEmployee extends StatefulWidget {
  const ManageEmployee({super.key});

  @override
  State<ManageEmployee> createState() => _ManageEmployeeState();
}

class _ManageEmployeeState extends State<ManageEmployee> {
  final UserProvider _prov = UserProvider();
  List<User>? employes;
  bool cargado = false;
  List<User>? employess = [];
  final RegisterEmployeeController _con = RegisterEmployeeController();

  @override
  void initState() {
    super.initState();
    _con.init(context);
    dataInit();
  }

  void dataInit() async {
    ResponseApi api = await _prov.getAllEmployes();
    List<User> listEmp = convertToUserList(api.data);

    setState(() {
      employes = listEmp;
      cargado = true;
    });
  }

  void searchEmpServer(String name) async {
    List<User> usrsFind = await _prov.findByUserName(name);
    setState(() {
      employess = usrsFind;
    });
  }

  Widget textModified(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w600),
    );
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
    return !cargado
        ? const Center(
            child: ProgressRing(),
          )
        : employessTbale(employes!, context);
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
                    SearchEmployee(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(child: dataInProcess()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FilledButton(
                          child: const Text("Agregar nuevo empleado"),
                          onPressed: () {
                            showContentDialogEdit(
                                context, _con, "Registrar nuevo empleado");
                          }),
                    )
                  ]),
            ),
          )),
    );
  }

  void showContentDialogEdit(
      context, RegisterEmployeeController _con, String description) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        constraints: const BoxConstraints(maxHeight: 700, maxWidth: 500),
        title: Text(description),
        content: ResgisterEmployee(_con),
        actions: [
          Button(
            child: const Text('Agregar'),
            onPressed: () {
              _con.register();
              Future.delayed(const Duration(milliseconds: 2000), () {
                dataInit();
                Navigator.pop(context, 'User deleted file');
              });
            },
          ),
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
  }
}
