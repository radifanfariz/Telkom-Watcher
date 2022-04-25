import 'dart:developer';

import 'package:get/get.dart';

import '../../constants.dart';
import '../models/dropdown_items_model.dart';

class DropdownItemsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return DropdownItems.fromJson(map);
      if (map is List) {
        return map.map((item) => DropdownItems.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<DropdownItems?> getDropdownItems() async {
    final response = await get('dropdown-item-second');
    log("API response: ${response.bodyString}");
    return response.body;
  }

  Future<DropdownItems?> getDropdownItemsRemarks(String treg, String witel) async {
    final response = await get('dropdown-item-remarks?treg=${treg}&witel=${witel}');
    log("API response: ${response.bodyString}");
    return response.body;
  }

  Future<Response<DropdownItems>> postDropdownItems(
          DropdownItems dropdownitems) async =>
      await post('dropdownitems', dropdownitems);
  Future<Response> deleteDropdownItems(int id) async =>
      await delete('dropdownitems/$id');
}
