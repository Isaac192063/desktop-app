import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/User.dart';
import 'package:desktop_app/domain/service/user_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class EmployeesProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  List<User> _listaEmployess = [];

  List<User> get getEmployees => _listaEmployess;

  bool cargando = false;

  void setEmployees() async {
    cargando = true;
    notifyListeners();

    try {
      ResponseApi api = await _userService.getAllEmployes();
      List<User> employess = convertToUserList(api.data);
      _listaEmployess = employess;
      cargando = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      throw "Ocurrio un error al traer la lista de los empleaods";
    }
  }
}
