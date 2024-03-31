import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/api/response_api.dart';
import 'package:fluent_ui/fluent_ui.dart';

class SegundaScreen extends StatefulWidget {
  const SegundaScreen({super.key});

  @override
  State<SegundaScreen> createState() => _SegundaScreenState();
}

class _SegundaScreenState extends State<SegundaScreen> {
  int num = 0;
  Future<List<User>>? users;
  ResponseApi api = ResponseApi();
  bool cargado = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      // users = api.getData(); // Actualiza el estado con los datos obtenidos
      cargado = true; // Cambia el estado de cargado a verdadero
    });
  }

  Widget us(BuildContext context) {
    return FutureBuilder(
      future: users,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<User> us = snapshot.data ?? [];

          return ListView.builder(
              itemCount: us.length,
              itemBuilder: (context, index) {
                return ListTile.selectable(
                  leading: SizedBox(
                    height: 100,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ColoredBox(
                        color: Colors.accentColors[index ~/ 20],
                        child: const Placeholder(),
                      ),
                    ),
                  ),
                  title: Text(us[index].name),
                  subtitle: const Text('With a custom subtitle'),
                  selectionMode: ListTileSelectionMode.single,
                );
              });
        } else {
          cargado = true;
          return Text("error");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        content: Center(
      child: cargado ? us(context) : ProgressRing(),
    ));
  }
}
