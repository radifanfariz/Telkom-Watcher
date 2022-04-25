class TrackingHistoryDetailModel {
  String? code;
  String? status;
  List<Data>? data;

  TrackingHistoryDetailModel({this.code, this.status, this.data});

  TrackingHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final data = <String, dynamic>{};
  //   data['code'] = code;
  //   data['status'] = status;
  //   if (data != null) {
  //     data['data'] = data.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Data {
  int? id;
  String? userId;
  double? lat;
  double? lgt;
  String? token;
  String? dateTime;

  Data({this.lat, this.lgt, this.token});

  Data.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lgt = json['lgt'];
    token = json['token'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['lat'] = lat;
    data['lgt'] = lgt;
    data['token'] = token;
    data['date_time'] = dateTime;
    return data;
  }
}
