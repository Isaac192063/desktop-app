import 'package:desktop_app/domain/providers/mode_contrast_provider.dart';
import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:desktop_app/gui/widgets/button_customize.dart';
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
        child: buttonCustomize(
            text: "Cambiar Tema 2",
            execute: () {
              context.read<ModeContrastProvider>().setMode();
            },
            color: MyColor.btnOscuroColor));
  }
}
