class Packaging {
  String? id;
  String? hydrostaticDate;
  String? owner;
  int? cttId;
  int? tpgCod;
  bool? empty;
  bool? inStorage;
  Content? content;
  TypePackaging? typePackaging;

  Packaging(
      {this.id,
      this.hydrostaticDate,
      this.owner,
      this.cttId,
      this.tpgCod,
      this.inStorage,
      this.empty,
      this.content,
      this.typePackaging});

  Packaging.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hydrostaticDate = json['hydrostatic_date'];
    owner = json['owner'];
    cttId = json['ctt_id'];
    tpgCod = json['tpg_cod'];
    empty = json['empty'];
    inStorage = json['inStorage'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    typePackaging = json['typePackaging'] != null
        ? new TypePackaging.fromJson(json['typePackaging'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hydrostatic_date'] = this.hydrostaticDate;
    data['owner'] = this.owner;
    data['ctt_id'] = this.cttId;
    data['tpg_cod'] = this.tpgCod;
    data['inStorage'] = this.inStorage;
    data['empty'] = this.empty;
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
  int? id;
  String? name;
  String? color;

  Content({this.id, this.name, this.color});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}

class TypePackaging {
  int? cod;
  double? size;
  String? pressureAmount;

  TypePackaging({this.cod, this.size, this.pressureAmount});

  TypePackaging.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    size = json['size'].toDouble();
    pressureAmount = json['pressure_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['size'] = this.size;
    data['pressure_amount'] = this.pressureAmount;
    return data;
  }
}
