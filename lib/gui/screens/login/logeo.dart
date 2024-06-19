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
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Center(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [
            0.1,
            0.4,
            0.6,
            0.9,
          ],
          colors: [
            MyColor.btnOscuroColor,
            MyColor.btnClaroColor,
            MyColor.medio,
            MyColor.claro,
          ],
        )),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: FractionallySizedBox(
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
                      "Iniciar sesion",
                      style: TextStyle(
                          color: Color.fromARGB(255, 82, 82, 82),
                          fontSize: 45,
                          fontWeight: FontWeight.w600),
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
                            enableSuggestions: true,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.7,
                                    color: Colors.black,
                                    strokeAlign: BorderSide.strokeAlignInside,
                                    style: BorderStyle.solid)),
                            placeholder: "Usuario",
                            style: const TextStyle(fontSize: 23),
                            padding: const EdgeInsets.all(10),
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
                              padding: const EdgeInsets.all(10),
                              style: const TextStyle(
                                  fontSize: 23,
                                  decorationStyle: TextDecorationStyle.wavy),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.7,
                                      color: Colors.black,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                      style: BorderStyle.solid)),
                              controller: _con.passwordController,
                            )),
                      ),
                    ]),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (event) {
                            setState(() {
                              hover = true;
                            });
                          },
                          onExit: (event) {
                            setState(() {
                              hover = false;
                            });
                          },
                          child: hover
                              ? btn2(MyColor.btnAcepHover)
                              : btn2(MyColor.btnAcep)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget btn2(Color color) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: ButtonState.all(color),
        padding: ButtonState.all(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 40)),
        textStyle: ButtonState.all(const TextStyle(fontSize: 25)),
      ),
      child: const Text('Ingresar'),
      onPressed: () {
        _con.enviar(context);
      },
    );
  }
}
