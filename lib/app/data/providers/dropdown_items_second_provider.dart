import 'dart:developer';

import 'package:get/get.dart';

import '../../constants.dart';
import '../models/dropdown_items_model.dart';
import '../models/dropdown_items_second_model.dart';

class DropdownItemsSecondProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return DropdownItemsSecond.fromJson(map);
      if (map is List) {
        return map.map((item) => DropdownItemsSecond.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<DropdownItemsSecond?> getDropdownItemsTreg() async {
    final response = await get('dropdown-item-treg');
    log("API response: ${response.bodyString}");
    return response.body;
  }

  Future<DropdownItemsSecond?> getDropdownItemsWitel(String treg) async {
    final response = await get('dropdown-item-witel?treg=${treg}');
    log("API response: ${response.bodyString}");
    return response.body;
  }

  Future<DropdownItemsSecond?> getDropdownItemsRoute(String treg,String witel,String remark) async {
    final response = await get('dropdown-item-routes?treg=${treg}&witel=${witel}&remarks=${remark}');
    log("API response: ${response.bodyString}");
    return response.body;
  }
}
