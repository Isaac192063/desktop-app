import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());


List<Customer> convertToCustomerList(List<dynamic> customerList) {
  return customerList.map((customerData) => Customer.fromJson(customerData)).toList();
}



class Customer {
  String? identification;
  String? firstName;
  String? middleName;
  String? lastName;
  String? lastName2;
  String? email;
  String? birthDate;
  String? phoneNumber;
  String? address;
  String? neighborhood;
  bool? state;
  String? warranty;
  String? typePerson;
  String? ctyId;
  String? dptCtyId;
  City? city;

  Customer(
      {this.identification,
      this.firstName,
      this.middleName,
      this.lastName,
      this.lastName2,
      this.email,
      this.birthDate,
      this.phoneNumber,
      this.address,
      this.neighborhood,
      this.state,
      this.warranty,
      this.typePerson,
      this.ctyId,
      this.dptCtyId,
      this.city});

  Customer.fromJson(Map<String, dynamic> json) {
    identification = json['identification'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    lastName2 = json['last_name_2'];
    email = json['email'];
    birthDate = json['birthDate'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    neighborhood = json['neighborhood'];
    state = json['state'];
    warranty = json['warranty'];
    typePerson = json['typePerson'];
    ctyId = json['cty_id'];
    dptCtyId = json['dpt_cty_id'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identification'] = this.identification;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['last_name_2'] = this.lastName2;
    data['email'] = this.email;
    data['birthDate'] = this.birthDate;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['neighborhood'] = this.neighborhood;
    data['state'] = this.state;
    data['warranty'] = this.warranty;
    data['typePerson'] = this.typePerson;
    data['cty_id'] = this.ctyId;
    data['dpt_cty_id'] = this.dptCtyId;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class City {
  String? id;
  String? name;
  String? dptId;

  City({this.id, this.name, this.dptId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dptId = json['dpt_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dpt_id'] = this.dptId;
    return data;
  }
}