import 'dart:developer';

import 'package:get/get.dart';
import 'package:trackernity_watcher/app/data/models/login_post_params_model.dart';

import '../../constants.dart';
import '../models/login_model.dart';

class LoginProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Login.fromJson(map);
      if (map is List) return map.map((item) => Login.fromJson(item)).toList();
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  // Future<Login?> getLogin(int id) async {
  //   final response = await get('login/$id');
  //   return response.body;
  // }

  // Future<Response<Login>> postLogin(LoginPostParams loginPostParams) async =>
  //     await post('login', loginPostParams.toJson(), headers: {"Content-Type": "application/json"});

  Future<Response> postLogin(LoginPostParams loginPostParams) async {
    final response = await post('login', loginPostParams.toJson());
    log("test Login:${response.bodyString}");
    return response;
  }

  // Future<Response> deleteLogin(int id) async => await delete('login/$id');
}
