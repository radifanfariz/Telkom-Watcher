class Signup {
  String? code;
  String? status;
  List<Data>? data;

  Signup({this.code, this.status, this.data});

  Signup.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? dateTime;

  Data({this.userId, this.dateTime});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['date_time'] = dateTime;
    return data;
  }
}
