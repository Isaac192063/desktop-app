import 'package:desktop_app/gui/screens/login/logeoControllers.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Logeo extends StatefulWidget {
  const Logeo({super.key});

  @override
  State<Logeo> createState() => _LogeoState();
}

class _LogeoState extends State<Logeo> {
  final LogeoController _con = LogeoController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Center(
          child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: FractionallySizedBox(
            // heightFactor: 0.5,
            widthFactor: .5,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColor.primaryKey,
                    border: Border.all(color: Colors.black, width: .5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
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
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                          label: "Ingrese el usuario",
                          child: TextBox(
                            placeholder: "Usuario",
                            style: const TextStyle(fontSize: 20),
                            padding: const EdgeInsets.all(15),
                            expands: false,
                            controller: _con.userCOntroller,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InfoLabel(
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20),
                            label: "Ingrese la contraseña",
                            child: PasswordBox(
                              revealMode: PasswordRevealMode.peekAlways,
                              placeholder: "Contraseña",
                              padding: const EdgeInsets.all(15),
                              style: const TextStyle(
                                  fontSize: 20,
                                  decorationStyle: TextDecorationStyle.wavy),
                              controller: _con.passwordController,
                            )),
                      ),
                    ]),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: ButtonState.all(MyColor.btnColor),
                          padding: ButtonState.all(const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40)),
                          textStyle:
                              ButtonState.all(const TextStyle(fontSize: 25)),
                        ),
                        child: const Text('Ingresar'),
                        onPressed: () {
                          _con.enviar(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
