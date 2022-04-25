class DropdownItemsAuth {
  String? code;
  String? regional;
  String? witel;
  String? unit;

  DropdownItemsAuth({this.code, this.regional, this.witel, this.unit});

  DropdownItemsAuth.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    regional = json['regional'];
    witel = json['witel'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['regional'] = regional;
    data['witel'] = witel;
    data['unit'] = unit;
    return data;
  }
}
