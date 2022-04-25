import 'dart:developer';

import 'package:get/get.dart';
import 'package:trackernity_watcher/app/data/models/location_data_gangguan_response_model.dart';

import '../../constants.dart';
import '../models/location_data_perkiraan_response_model.dart';

class LocationDataGangguanResponseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return LocationDataGangguanResponse.fromJson(map);
      }
      if (map is List) {
        return map
            .map((item) => LocationDataGangguanResponse.fromJson(item))
            .toList();
      }
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<List<LocationDataGangguanResponse?>> getLocationDataGangguanResponse(
      String remark) async {
    final response = await get('gangguan?remarks=${remark}');
    log("API response: ${response.bodyString}");
    return response.body;
  }

// Future<Response<LocationDataPerkiraanResponse>>
//     postLocationDataPerkiraanResponse(
//             LocationDataPerkiraanResponse
//                 locationdataperkiraanresponse) async =>
//         await post(
//             'locationdataperkiraanresponse', locationdataperkiraanresponse);
// Future<Response> deleteLocationDataPerkiraanResponse(int id) async =>
//     await delete('locationdataperkiraanresponse/$id');
}
