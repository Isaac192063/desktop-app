import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/customer_model.dart';
import 'package:desktop_app/domain/service/customer_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomerController {
  final CustomerService _customerService = CustomerService();
  TextEditingController idController = TextEditingController();//
  TextEditingController firstNameController = TextEditingController();//
  TextEditingController middleNameController = TextEditingController();//
  TextEditingController lastNameController = TextEditingController();//
  TextEditingController lastName2Controller = TextEditingController();//
  TextEditingController emailController = TextEditingController();//
  TextEditingController phoneController = TextEditingController();//
  TextEditingController addressController = TextEditingController();//
  TextEditingController neighborhoodController = TextEditingController();//
  TextEditingController warrantyController = TextEditingController();//
  TextEditingController typePersonController = TextEditingController();//
  TextEditingController ctyIdController = TextEditingController();//
  TextEditingController ctyTextController = TextEditingController();//
  TextEditingController dptIdController = TextEditingController();//
  TextEditingController birthDateController = TextEditingController();//
  City? city;

  Future<List<Customer>> getAllCustomers() async {
    try {
      ResponseApi api = await _customerService.getAllCustomers();
      List data = api.data;
      List<Customer> listCustomers =
          data.map((e) => Customer.fromJson(e)).toList();
      return listCustomers;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> editCustomer() async {
    String identification = idController.text.trim();
    String email = emailController.text.trim();
    String birthDate = birthDateController.text.trim();
    String typePerson = typePersonController.text.trim();
    String city = ctyIdController.text.trim();
    String department = dptIdController.text.trim();
    String firstName = firstNameController.text.trim();
    String middleName = middleNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String lastName2 = lastName2Controller.text.trim();
    String phoneNumber = phoneController.text.trim();
    String address = addressController.text.trim();
    String neighborhood = neighborhoodController.text.trim();
    String warranty = warrantyController.text.trim();

    print(identification);
    print(email);
    print(birthDate);
    print(typePerson);
    print(department);
    print(firstName);
    print(middleName);
    print(lastName);
    print(lastName2);
    print(phoneNumber);
    print(neighborhood);
    print(city);
    print(warranty);
    print(address);

    try {
      Customer editedCustomer = Customer(
        address: address,
        ctyId: city,
        dptCtyId: department,
        neighborhood: neighborhood,
        phoneNumber: phoneNumber,
        warranty: warranty,
        state: true, // Assuming a default state
        typePerson: typePerson,
        birthDate: birthDate,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        lastName2: lastName2,
        email: email,
        identification: identification,
      );

      ResponseApi response = await _customerService.editCustomerService(editedCustomer);

      
      print(response.success);
    } catch (e) {
      print('Exception occurred while registering customer: $e');
    }
  }


   Future<void> registerCustomer() async {
    String email = emailController.text.trim();
    String identification = idController.text.trim();
    String birthDate = birthDateController.text.trim();
    String typePerson = typePersonController.text.trim();
    String city = ctyIdController.text.trim();
    String department = dptIdController.text.trim();
    String firstName = firstNameController.text.trim();
    String middleName = middleNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String lastName2 = lastName2Controller.text.trim();
    String phoneNumber = phoneController.text.trim();
    String address = addressController.text.trim();
    String neighborhood = neighborhoodController.text.trim();
    String warranty = warrantyController.text.trim();

    print("Enviando.....");
    print('email:$email');
    print('id:$identification');
    print('fecha:$birthDate');
    print('tipo:$typePerson');
    print('departamento:$department');
    print('primernombre:$firstName');
    print('Segundonombre:$middleName');
    print('primerapellido:$lastName');
    print('Segundoapellido:$lastName2');
    print('telefono:$phoneNumber');
    print('barrio:$neighborhood');
    print('ciuddad:$city');
    print('garantia:$warranty');
    print('direccion:$address');

    try {
      Customer newCustomer = Customer(
        address: address,
        ctyId: city,
        dptCtyId: department,
        neighborhood: neighborhood,
        phoneNumber: phoneNumber,
        warranty: warranty,
        state: true, // Assuming a default state
        typePerson: typePerson,
        birthDate: birthDate,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        lastName2: lastName2,
        email: email,
        identification: identification,
      );

      ResponseApi response = await _customerService.newCustomer(newCustomer);
      print(response.success);
    } catch (e) {
      print('Exception occurred while registering customer: $e');
    }
  }
}