class LocationDataRealtime {
  String? nama;
  String? regional;
  String? witel;
  String? unit;
  String? cProfile;
  String? userId;
  double? lat;
  double? lgt;
  int? continuity;
  String? remarks;
  String? token;

  LocationDataRealtime(
      {this.nama,
        this.regional,
      this.witel,
      this.unit,
      this.cProfile,
      this.userId,
      this.lat,
      this.lgt,
      this.continuity,
      this.remarks,
      this.token});

  LocationDataRealtime.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    regional = json['regional'];
    witel = json['witel'];
    unit = json['unit'];
    cProfile = json['c_profile'];
    userId = json['user_id'];
    lat = json['lat'];
    lgt = json['lgt'];
    continuity = json['continuity'];
    remarks = json['remarks'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama'] = nama;
    data['regional'] = regional;
    data['witel'] = witel;
    data['unit'] = unit;
    data['c_profile'] = cProfile;
    data['user_id'] = userId;
    data['lat'] = lat;
    data['lgt'] = lgt;
    data['continuity'] = continuity;
    data['remarks'] = remarks;
    data['token'] = token;
    return data;
  }
}
