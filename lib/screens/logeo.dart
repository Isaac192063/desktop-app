import 'package:desktop_app/controllers/logeoControllers.dart';
import 'package:desktop_app/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Logeo extends StatefulWidget {
  const Logeo({super.key});

  @override
  State<Logeo> createState() => _LogeoState();
}

class _LogeoState extends State<Logeo> {
  final LogeoController _con = LogeoController();

  void notification(BuildContext context) async {
    await displayInfoBar(context, builder: (context, close) {
      return InfoBar(
        title: const Text('You can not do that :/'),
        content: const Text(
            'A proper warning message of why the user can not do that :/'),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: InfoBarSeverity.warning,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
          child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: FractionallySizedBox(
          heightFactor: 0.6,
          widthFactor: .5,
          child: Container(
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyColor.primaryKey,
                border: Border.all(color: Colors.black, width: .5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Color de la sombra
                    spreadRadius: 2, // Extensión de la sombra
                    blurRadius: 4, // Difuminado de la sombra
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Center(
                    child: Text(
                  "Inicio",
                  style: TextStyle(color: Colors.black, fontSize: 50),
                )),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InfoLabel(
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                      label: "Ingrese el usuario",
                      child: TextBox(
                        placeholder: "Name",
                        style: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.all(15),
                        expands: false,
                        controller: _con.user,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InfoLabel(
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                        label: "Ingrese la contraseña",
                        child: PasswordBox(
                          revealMode: PasswordRevealMode.peekAlways,
                          placeholder: "Password",
                          padding: const EdgeInsets.all(15),
                          style: const TextStyle(
                              fontSize: 20,
                              decorationStyle: TextDecorationStyle.wavy),
                          controller: _con.password,
                        )),
                  ),
                ]),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: ButtonState.all(MyColor.btnColor),
                      padding: ButtonState.all(const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 30)),
                      textStyle: ButtonState.all(const TextStyle(fontSize: 25)),
                    ),
                    child: const Text('Iniciar secion'),
                    onPressed: () {
                      // notification(context);
                      _con.enviar(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
