class AlproModel {
  dynamic id;
  String? userId;
  double? lat;
  double? lgt;
  dynamic dateTime;
  String? continuity;
  String? remarks;
  String? descriptions;

  AlproModel(
      {this.id,
      this.userId,
      this.lat,
      this.lgt,
      this.dateTime,
      this.continuity,
      this.remarks,
      this.descriptions});

  AlproModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lgt = json['lgt'];
    dateTime = json['date_time'];
    continuity = json['continuity'];
    remarks = json['remarks'];
    descriptions = json['descriptions'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['lat'] = lat;
    data['lgt'] = lgt;
    data['date_time'] = dateTime;
    data['continuity'] = continuity;
    data['remarks'] = remarks;
    data['descriptions'] = descriptions;
    return data;
  }
}
