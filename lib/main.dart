import 'package:desktop_app/screens/logeo.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        title: 'Material',
        debugShowCheckedModeBanner: false,
        color: Colors.errorPrimaryColor,
        theme: FluentThemeData.light(),
        home: Logeo());
  }
}
