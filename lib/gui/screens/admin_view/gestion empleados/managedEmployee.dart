import 'package:desktop_app/domain/providers/employess_provider.dart';
import 'package:desktop_app/domain/service/excel_user_service.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/edit_detail_Employee.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/search_employee.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/button_customize.dart';
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
  final ExceluserService _exceluserService = ExceluserService();

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
      _exceluserService.context = context;
    });
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
                SearchEmployee(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: buttonCustomize(
                            context: context,
                            text: "Agregar Empleado",
                            execute: () {
                              EditRegisterEmp(
                                  context, _con, "Registrar nuevo empleado");
                              _con.reset();
                            },
                            color: MyColor.btnOscuroColor)),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: buttonCustomize(
                            context: context,
                            text: "Descargar excel",
                            execute: _exceluserService.dowloadUsers,
                            color: MyColor.btnOscuroColor)),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(child: dataInProcess()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
