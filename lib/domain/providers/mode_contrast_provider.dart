import 'package:fluent_ui/fluent_ui.dart';

class ModeContrastProvider extends ChangeNotifier {
  bool _modoOscure = false;

  bool get getMode => _modoOscure;

  void setMode() {
    _modoOscure = !_modoOscure;
    notifyListeners();
  }
}
