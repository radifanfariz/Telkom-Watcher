class TrackingHistoryModel {
  String? code;
  String? status;
  List<Data>? data;

  TrackingHistoryModel({this.code, this.status, this.data});

  TrackingHistoryModel.fromJson(Map<String, dynamic> json) {
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
  //     data['data'] = data?.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Data {
  String? token;
  String? userId;
  String? remarks;
  String? date_time;
  int? id;

  Data({this.token, this.userId, this.remarks,this.date_time,this.id});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    remarks = json['remarks'];
    date_time = json['date_time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['user_id'] = userId;
    data['remarks'] = remarks;
    data['date_time'] = date_time;
    data['id'] = id;
    return data;
  }
}
