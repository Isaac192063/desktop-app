import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/domain/providers/employess_provider.dart';
import 'package:desktop_app/domain/providers/mode_contrast_provider.dart';
import 'package:desktop_app/gui/screens/admin_view/navigation_page_admin.dart';
import 'package:desktop_app/gui/screens/login/logeo.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ModeContrastProvider(),
    ),
    ChangeNotifierProvider(create: (_) => EmployeesProvider())
  ], child: const MyApp()));
}

// usuario de ejemplo
User user = User(
    id: 1,
    name: "gerardo",
    lastName: "duarte",
    phoneNumber: "31226234631",
    initialData: DateTime.now(),
    email: "gerardo@gmail.com",
    password: "martin",
    image: "1716681658040.jpg",
    enabled: true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Material',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ModeContrastProvider>().getMode
          ? FluentThemeData.dark()
          : FluentThemeData.light(),
      // home: NavigationPageAdmin(user)
      home: const Logeo(),
    );
  }
}
// 1234568
// 1234568