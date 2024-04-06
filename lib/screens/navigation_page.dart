import 'package:desktop_app/screens/registerOrder/registerOrder.dart';
import 'package:desktop_app/screens/segunda_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _countPage = 0;
  int num = 1;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
          title: Row(children: [
            Text("Segunda navegacion?"),
          ]),
          leading: Center(
            child: FlutterLogo(
              size: 25,
            ),
          )),
      pane: NavigationPane(
          size: const NavigationPaneSize(openWidth: 250),
          header: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: DefaultTextStyle(
              style: FluentTheme.of(context).typography.title!,
              child: const Text("Aplicacion escritorio"),
            ),
          ),
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              body: const PrimeraScreen(),
              title: const Text("Inicio", style: TextStyle(fontSize: 16)),
            ),
            PaneItemSeparator(),
            PaneItem(
                icon: const Icon(FluentIcons.user_window),
                body: const SegundaScreen(),
                infoBadge: InfoBadge(source: Text("$num")),
                title: const Text("Compras registradas",
                    style: TextStyle(fontSize: 16)))
          ],
          selected: _countPage,
          onChanged: (i) {
            setState(() {
              _countPage = i;
            });
          }),
    );
  }
}
