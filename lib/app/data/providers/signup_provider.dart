import 'dart:developer';

import 'package:get/get.dart';
import 'package:trackernity_watcher/app/data/models/signup_post_params_model.dart';

import '../../constants.dart';
import '../models/signup_model.dart';

class SignupProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Signup.fromJson(map);
      if (map is List) return map.map((item) => Signup.fromJson(item)).toList();
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  // Future<Signup?> getSignup(int id) async {
  //   final response = await get('signup/$id');
  //   return response.body;
  // }

  Future<Response> postSignup(SignupPostParams signupPostParams) async {
    final response = await post('sign-up', signupPostParams.toJson());
    log("test SignUp:${response.bodyString}");
    return response;
  }

  // Future<Response> deleteSignup(int id) async => await delete('signup/$id');
}
