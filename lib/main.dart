import 'package:desktop_app/screens/login/logeo.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        title: 'Material',
        debugShowCheckedModeBanner: false,
        theme: FluentThemeData.light(),
        home: const Logeo());
  }
}
