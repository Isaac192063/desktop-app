import 'package:desktop_app/api/models/User.dart';
import 'package:desktop_app/screens/admin_view/navigation_page_admin.dart';
import 'package:desktop_app/screens/login/logeo.dart';
import 'package:desktop_app/screens/orders/registerOrder.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() => runApp(const MyApp());
// usuario de ejemplo
User user = User(
    idEmployee: 1,
    name: "gerardo",
    lastName: "duarte",
    phoneNumber: "31226234631",
    initialData: DateTime.now(),
    email: "gerardo@gmail.com",
    password: "martin",
    image: "paisaje-e1549600034372.jpg");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        routes: {
          '/Registrar_venta': (context) => const RegisterOrder(), // Define la página que quieres mostrar en el body
        },
        title: 'Material',
        debugShowCheckedModeBanner: false,
        theme: FluentThemeData.light(),
        home: NavigationPageAdmin(user));
  }
}
