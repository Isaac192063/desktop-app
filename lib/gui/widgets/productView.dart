import 'package:fluent_ui/fluent_ui.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _LogeoState();
}

class _LogeoState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: EdgeInsets.zero,
        content: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                FilledButton(
                    child: const Text("volver"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const Text("esta es la informacion que se deberia ver"),
              ],
            ),
          ),
        ));
  }
}
