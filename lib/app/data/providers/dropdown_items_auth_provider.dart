import 'dart:developer';

import 'package:get/get.dart';

import '../../constants.dart';
import '../models/dropdown_items_auth_model.dart';

class DropdownItemsAuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return DropdownItemsAuth.fromJson(map);
      if (map is List) {
        return map.map((item) => DropdownItemsAuth.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<List<DropdownItemsAuth?>> getDropdownItemsAuth() async {
    final response = await get('dropdown-item-auth');
    log("API response: ${response.bodyString}");
    return response.body;
  }

  Future<Response<DropdownItemsAuth>> postDropdownItemsAuth(
          DropdownItemsAuth dropdownitemsauth) async =>
      await post('dropdownitemsauth', dropdownitemsauth);
  Future<Response> deleteDropdownItemsAuth(int id) async =>
      await delete('dropdownitemsauth/$id');
}
