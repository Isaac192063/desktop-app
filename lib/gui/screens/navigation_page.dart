import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/gui/screens/config%20gui/config_page.dart';
import 'package:desktop_app/gui/screens/customer/index_customer.dart';
import 'package:desktop_app/gui/screens/product/Product_page.dart';
import 'package:desktop_app/gui/screens/registerOrder/registerOrder.dart';
import 'package:desktop_app/gui/widgets/options.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NavigationPage extends StatefulWidget {
  final User user;
  const NavigationPage(this.user, {super.key});
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _countPage = 0;
  int num = 1;
  bool loading = true;
  User? userData;

  @override
  void initState() {
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
                        const Text("RDQ Desktop"),
                        Text(userData!.name),
                      ],
                    ),
                  ),
                ),
                items: [
                  PaneItem(
                    icon: const Icon(FluentIcons.home),
                    body: const PrimeraScreen(),
                    title: const Text("Inicio", style: TextStyle(fontSize: 16)),
                  ),
                  PaneItemSeparator(),
                  // PaneItem(
                  //     icon: const Icon(FluentIcons.user_window),
                  //     body: const SegundaScreen(),
                  //     infoBadge: InfoBadge(source: Text("$num")),
                  //     title: const Text("Compras registradas",
                  //         style: TextStyle(fontSize: 16))),
                  PaneItem(
                      icon: const Icon(FluentIcons.product),
                      title: const Text("Productos",
                          style: TextStyle(fontSize: 16)),
                      body: const ProductPage()),
                  PaneItem(
                      icon: const Icon(FluentIcons.product),
                      title: const Text("Productos",
                          style: TextStyle(fontSize: 16)),
                      body: const IndexCustomer()),
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
