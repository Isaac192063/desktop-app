import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/api/response_api.dart';
import 'package:desktop_app/api/user_provider.dart';
import 'package:desktop_app/components/table.dart';
import 'package:desktop_app/screens/admin_view/registerEmployee/registerEmployee.dart';
import 'package:desktop_app/screens/admin_view/registerEmployee/registeremployeeController.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ManageEmployee extends StatefulWidget {
  const ManageEmployee({super.key});

  @override
  State<ManageEmployee> createState() => _ManageEmployeeState();
}

class _ManageEmployeeState extends State<ManageEmployee> {
  String? selectedEmploye;
  final UserProvider _prov = UserProvider();
  List<User>? employes;
  bool cargado = false;
  List<String> employess = [
    'Abyssinian',
    'Aegean',
    'American Bobtail',
    'American Curl'
  ];
  final RegisterEmployeeController _con = new RegisterEmployeeController();
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
      child: AutoSuggestBox<String>(
        decoration: BoxDecoration(color: Color.fromARGB(255, 252, 255, 254)),
        items: employess.map((employee) {
          return AutoSuggestBoxItem<String>(
              value: employee,
              label: employee,
              onFocusChange: (focused) {
                if (focused) {
                  debugPrint('Focused $employee');
                }
              });
        }).toList(),
        onSelected: null,
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
                    searchEmployee(context),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(child: dataInProcess()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FilledButton(
                          child: const Text("Agregar nuevo empleado"),
                          onPressed: () {
                            print("object");
                            showContentDialog(context);
                          }),
                    )
                  ]),
            ),
          )),
    );
  }

  void showContentDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        constraints: BoxConstraints(maxHeight: 700, maxWidth: 500),
        title: const Text('Agregar nuevo Empleado'),
        content: ResgisterEmployee(_con),
        actions: [
          Button(
            child: const Text('Agregar'),
            onPressed: () async {
              _con.register();
              Future.delayed(Duration(seconds: 1), () {
                dataInit();
              });
              Navigator.pop(context, 'User deleted file');
            },
          ),
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }
}
