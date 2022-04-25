class Login {
  String? code;
  String? status;
  List<Data>? data;

  Login({this.code, this.status, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    dataMap['code'] = code;
    dataMap['status'] = status;
    if (data != null) {
      dataMap['data'] = data?.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class Data {
  String? token;
  User? user;
  String? dateTime;

  Data({this.token, this.user, this.dateTime});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['date_time'] = dateTime;
    return data;
  }
}

class User {
  int? idx;
  dynamic idy;
  String? regional;
  String? witel;
  String? userid;
  dynamic nama;
  dynamic cProfile;
  String? pass;
  String? flagging;
  dynamic handphone;
  dynamic imei;
  dynamic team;

  User(
      {this.idx,
      this.idy,
      this.regional,
      this.witel,
      this.userid,
      this.nama,
      this.cProfile,
      this.pass,
      this.flagging,
      this.handphone,
      this.imei,
      this.team});

  User.fromJson(Map<String, dynamic> json) {
    idx = json['idx'];
    idy = json['idy'];
    regional = json['regional'];
    witel = json['witel'];
    userid = json['userid'];
    nama = json['nama'];
    cProfile = json['c_profile'];
    pass = json['pass'];
    flagging = json['flagging'];
    handphone = json['handphone'];
    imei = json['imei'];
    team = json['team'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idx'] = idx;
    data['idy'] = idy;
    data['regional'] = regional;
    data['witel'] = witel;
    data['userid'] = userid;
    data['nama'] = nama;
    data['c_profile'] = cProfile;
    data['pass'] = pass;
    data['flagging'] = flagging;
    data['handphone'] = handphone;
    data['imei'] = imei;
    data['team'] = team;
    return data;
  }
}
