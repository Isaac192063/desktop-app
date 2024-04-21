import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/components/options.dart';
import 'package:desktop_app/components/setImgae.dart';
import 'package:desktop_app/screens/admin_view/dashboard/kardex.dart';
import 'package:desktop_app/screens/admin_view/registerEmployee/managedEmployee.dart';
import 'package:desktop_app/screens/registerOrder/registerOrder.dart';
import 'package:desktop_app/screens/segunda_screen.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NavigationPageAdmin extends StatefulWidget {
  final User user;

  const NavigationPageAdmin(this.user, {super.key});

  @override
  State<NavigationPageAdmin> createState() => _NavigationPageAdminState();
}

class _NavigationPageAdminState extends State<NavigationPageAdmin> {
  int _countPage = 0;
  int num = 1;

  bool loading = true;
  User? userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        userData = widget.user;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Center(child: const ProgressRing()))
        : NavigationView(
            appBar: NavigationAppBar(
                height: 50,
                actions: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        MyColor.btnClaroColor,
                        MyColor.btnClaroColor,
                        Colors.white
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8),
                        child: option(context),
                      )
                    ],
                  ),
                ),
                leading: null),
            pane: NavigationPane(
                size: const NavigationPaneSize(openWidth: 250),
                header: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: DefaultTextStyle(
                    style: FluentTheme.of(context).typography.title!,
                    child: Column(
                      children: [
                        setImage(userData!.image, 90),
                        Text(
                          "admin",
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        Text(userData!.name),
                      ],
                    ),
                  ),
                ),
                items: [
                  PaneItem(
                      icon: const Icon(FluentIcons.b_i_dashboard),
                      body: const kardex(),
                      title:
                          const Text("Inicio", style: TextStyle(fontSize: 16))),
                  PaneItemSeparator(),
                  PaneItem(
                    icon: const Icon(FluentIcons.business_card),
                    body: const PrimeraScreen(),
                    title: const Text("Registrar compra",
                        style: TextStyle(fontSize: 16)),
                  ),
                  PaneItem(
                      icon: const Icon(FluentIcons.user_window),
                      body: const SegundaScreen(),
                      infoBadge: InfoBadge(source: Text("$num")),
                      title: const Text("Compras registradas",
                          style: TextStyle(fontSize: 16))),
                  PaneItem(
                      icon: const Icon(FluentIcons.employee_self_service),
                      body: const ManageEmployee(),
                      infoBadge: InfoBadge(source: Text("$num")),
                      title: const Text("Empleados",
                          style: TextStyle(fontSize: 16))),
                ],
                selected: _countPage,
                onChanged: (i) {
                  setState(() {
                    _countPage = i;
                  });
                },
                footerItems: [
                  PaneItem(
                    icon: const Icon(FluentIcons.settings),
                    title: const Text('Settings'),
                    body: option(context),
                  ),
                ]),
          );
  }
}
