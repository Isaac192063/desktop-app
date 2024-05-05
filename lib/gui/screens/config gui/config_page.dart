import 'package:desktop_app/domain/providers/mode_contrast_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class ModeContrast extends StatefulWidget {
  const ModeContrast({super.key});

  @override
  State<ModeContrast> createState() => _ModeContrastState();
}

class _ModeContrastState extends State<ModeContrast> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        child: const Text("cambiar tema"),
        onPressed: () {
          context.read<ModeContrastProvider>().setMode();
        },
      ),
    );
  }
}
