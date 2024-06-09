import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/domain/providers/mode_contrast_provider.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/main_screen.dart';
import 'package:desktop_app/gui/screens/admin_view/kardex/indexkardex.dart';
import 'package:desktop_app/gui/screens/config%20gui/config_page.dart';
import 'package:desktop_app/gui/screens/customer/customer_page.dart';
import 'package:desktop_app/gui/screens/orders/indexOrder.dart';
import 'package:desktop_app/gui/screens/orders/order2/registerOrder.dart';
import 'package:desktop_app/gui/screens/product/Product_page.dart';
import 'package:desktop_app/gui/widgets/options.dart';
import 'package:desktop_app/gui/widgets/setImgae.dart';
import 'package:desktop_app/gui/screens/admin_view/gestion%20empleados/managedEmployee.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class NavigationPageAdmin extends StatefulWidget {
  final User user;

  const NavigationPageAdmin(this.user, {super.key});

  @override
  State<NavigationPageAdmin> createState() => _NavigationPageAdminState();
}

class _NavigationPageAdminState extends State<NavigationPageAdmin> {
  int _countPage = 0;

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
            child: const Center(child: ProgressRing()))
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
                      colors: context.watch<ModeContrastProvider>().getMode
                          ? [
                              Colors.black,
                              MyColor.btnOscuroColor,
                              MyColor.btnOscuroColor,
                            ]
                          : [
                              Colors.white,
                              MyColor.btnClaroColor,
                              MyColor.btnClaroColor,
                            ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(
                          image: AssetImage("assets/imgs/icon_rdq.png")),
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
                        Text(userData!.name),
                      ],
                    ),
                  ),
                ),
                items: [
                  PaneItem(
                      icon: const Icon(FluentIcons.b_i_dashboard),
                      body: const MainScreen(),
                      title:
                          const Text("Inicio", style: TextStyle(fontSize: 16))),
                  PaneItemSeparator(),
                  PaneItemExpander(
                      icon: const Icon(FluentIcons.business_card),
                      body: const IndexOrder(),
                      title: const Text("Ventas registradas",
                          style: TextStyle(fontSize: 16)),
                      items: [
                        PaneItem(
                            icon: const Icon(FluentIcons.user_window),
                            body: const RegisterOrder(),
                            title: const Text("Registrar venta",
                                style: TextStyle(fontSize: 16))),
                      ]),
                  // PaneItem(
                  //     icon: const Icon(FluentIcons.user_window),
                  //     body: const SegundaScreen(),
                  //     infoBadge: InfoBadge(source: Text("$_numOrd")),
                  //     title: const Text("Compras registradas",
                  //         style: TextStyle(fontSize: 16))),
                  PaneItem(
                      icon: const Icon(FluentIcons.employee_self_service),
                      body: const ManageEmployee(),
                      title: const Text("Empleados",
                          style: TextStyle(fontSize: 16))),
                  PaneItem(
                      icon: const Icon(FluentIcons.list),
                      body: const IndexKardex(),
                      title:
                          const Text("Kardex", style: TextStyle(fontSize: 16))),
                  PaneItem(
                      icon: const Icon(FluentIcons.product),
                      title: const Text("Productos",
                          style: TextStyle(fontSize: 16)),
                      body: const ProductPage()),
                  PaneItem(
                      icon: const Icon(FluentIcons.user_clapper),
                      title: const Text("clientes",
                          style: TextStyle(fontSize: 16)),
                      body: const CustomerPage()),
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
