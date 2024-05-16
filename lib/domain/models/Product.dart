import 'dart:ffi';

class Product {
  String? idPackaging;
  String? hydrostaticDate;
  int? stock;
  String? supplier;
  int? idContent;
  int? idTypePackaging;
  Content? content;
  TypePackaging? typePackaging;

  Product(
      {this.idPackaging,
      this.hydrostaticDate,
      this.stock,
      this.supplier,
      this.idContent,
      this.idTypePackaging,
      this.content,
      this.typePackaging});

  Product.fromJson(Map<String, dynamic> json) {
    idPackaging = json['id_packaging'];
    hydrostaticDate = json['hydrostatic_date'];
    stock = json['stock'];
    supplier = json['supplier'];
    idContent = json['idContent'];
    idTypePackaging = json['idTypePackaging'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    typePackaging = json['typePackaging'] != null
        ? new TypePackaging.fromJson(json['typePackaging'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_packaging'] = this.idPackaging;
    data['hydrostatic_date'] = this.hydrostaticDate;
    data['stock'] = this.stock;
    data['supplier'] = this.supplier;
    data['idContent'] = this.idContent;
    data['idTypePackaging'] = this.idTypePackaging;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.typePackaging != null) {
      data['typePackaging'] = this.typePackaging!.toJson();
    }
    return data;
  }
}

class Content {
  int? idContent;
  String? name;
  String? unitMeasurement;
  double? price;

  Content({this.idContent, this.name, this.unitMeasurement, this.price});

  Content.fromJson(Map<String, dynamic> json) {
    idContent = json['id_content'];
    name = json['name'];
    unitMeasurement = json['unit_measurement'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_content'] = this.idContent;
    data['name'] = this.name;
    data['unit_measurement'] = this.unitMeasurement;
    data['price'] = this.price;
    return data;
  }
}

class TypePackaging {
  int? idTypePackaging;
  double? pressureAmount;
  double? size;
  double? price;
  String? color;

  TypePackaging(
      {this.idTypePackaging,
      this.pressureAmount,
      this.size,
      this.price,
      this.color});

  TypePackaging.fromJson(Map<String, dynamic> json) {
    idTypePackaging = json['id_type_packaging'];
    pressureAmount = json['pressure_amount'].toDouble();
    size = json['size'].toDouble();
    price = json['price'].toDouble();
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_type_packaging'] = this.idTypePackaging;
    data['pressure_amount'] = this.pressureAmount;
    data['size'] = this.size;
    data['price'] = this.price;
    data['color'] = this.color;
    return data;
  }
}
