class LoginPostParams {
  String? userId;
  // String? pass;
  Map<String,dynamic>? pass;

  LoginPostParams({this.userId, this.pass});

  // LoginPostParams.fromJson(Map<String, dynamic> json) {
  //   userId = json['user_id'];
  //   pass = json['pass'];
  // }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['pass'] = pass;
    return data;
  }
}
