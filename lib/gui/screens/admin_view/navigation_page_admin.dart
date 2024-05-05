import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/gui/screens/config%20gui/config_page.dart';
import 'package:desktop_app/gui/widgets/options.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/kardex.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/managedEmployee.dart';
import 'package:desktop_app/gui/screens/registerOrder/registerOrder.dart';
import 'package:desktop_app/gui/screens/segunda_screen.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NavigationPageAdmin extends StatefulWidget {
  final User user;

  const NavigationPageAdmin(this.user, {super.key});

  @override
  State<NavigationPageAdmin> createState() => _NavigationPageAdminState();
}

class _NavigationPageAdminState extends State<NavigationPageAdmin> {
  int _countPage = 0;
  final int _numOrd = 0;

  bool loading = true;
  User? userData;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
      setState(() {
        userData = widget.user;
        loading = false;
      });
    });
    super.initState();
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
                        Colors.white,
                        MyColor.btnClaroColor,
                        MyColor.btnClaroColor,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(image: AssetImage("assets/imgs/icon_rdq.png")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8),
                        child: option(context),
                      ),
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
                      infoBadge: InfoBadge(source: Text("$_numOrd")),
                      title: const Text("Compras registradas",
                          style: TextStyle(fontSize: 16))),
                  PaneItem(
                      icon: const Icon(FluentIcons.employee_self_service),
                      body: const ManageEmployee(),
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
                    body: const ModeContrast(),
                  ),
                ]),
          );
  }
}
