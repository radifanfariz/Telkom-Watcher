class LocationDataGangguanResponse {
  int? id;
  String? userId;
  double? lat;
  double? lgt;
  String? datetime;
  String? remarks;
  String? remarks2;
  String? descriptions;
  String? notes;
  int? flaggingGangguanSelesai;

  LocationDataGangguanResponse(
      {this.id,
        this.userId,
        this.lat,
        this.lgt,
        this.datetime,
        this.remarks,
        this.remarks2,
        this.descriptions,
        this.notes,
        this.flaggingGangguanSelesai});

  LocationDataGangguanResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lgt = json['lgt'];
    datetime = json['datetime'];
    remarks = json['remarks'];
    remarks2 = json['remarks2'];
    descriptions = json['descriptions'];
    notes = json['notes'];
    flaggingGangguanSelesai = json['flagging_ggn_selesai'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['lat'] = lat;
    data['lgt'] = lgt;
    data['datetime'] = datetime;
    data['remarks'] = remarks;
    data['remarks2'] = remarks2;
    data['descriptions'] = descriptions;
    data['notes'] = notes;
    data['flagging_ggn_selesai'] = flaggingGangguanSelesai;
    return data;
  }
}
