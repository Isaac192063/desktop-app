class Packaging {
  String? id;
  String? hydrostaticDate;
  String? owner;
  int? cttId;
  int? tpgCod;
  Content? content;
  TypePackaging? typePackaging;

  Packaging(
      {this.id,
      this.hydrostaticDate,
      this.owner,
      this.cttId,
      this.tpgCod,
      this.content,
      this.typePackaging});

  Packaging.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hydrostaticDate = json['hydrostatic_date'];
    owner = json['owner'];
    cttId = json['ctt_id'];
    tpgCod = json['tpg_cod'];
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    typePackaging = json['typePackaging'] != null
        ? TypePackaging.fromJson(json['typePackaging'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hydrostatic_date'] = hydrostaticDate;
    data['owner'] = owner;
    data['ctt_id'] = cttId;
    data['tpg_cod'] = tpgCod;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (typePackaging != null) {
      data['typePackaging'] = typePackaging!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['size'] = size;
    data['pressure_amount'] = pressureAmount;
    return data;
  }
}
