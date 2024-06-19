import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:desktop_app/domain/service/customer_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomersProvider extends ChangeNotifier {
  final CustomerService _customerService = CustomerService();

  List<Customer> _listaCustomers = [];

  List<Customer> get getCustomers => _listaCustomers;

  bool cargando = false;

  void setCustomers() async {
    cargando = true;
    notifyListeners();

    try {
      ResponseApi api = await _customerService.getAllCustomers();

      List<Customer> customers = convertToCustomerList(api.data);
      _listaCustomers = customers;
      cargando = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      // throw "Ocurrio un error al traer la lista de los empleaods";
    }
  }
}