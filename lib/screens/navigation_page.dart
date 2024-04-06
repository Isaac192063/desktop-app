import 'package:desktop_app/screens/registerOrder/registerOrder.dart';
import 'package:desktop_app/screens/segunda_screen.dart';
import 'package:desktop_app/utils/myColors.dart';
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
      appBar: NavigationAppBar(
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
            child: const Text(
              'Título con Degradado',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          leading: null),
      pane: NavigationPane(
          size: const NavigationPaneSize(openWidth: 250),
          header: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: DefaultTextStyle(
              style: FluentTheme.of(context).typography.title!,
              child: const Text("RDQ Desktop"),
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
