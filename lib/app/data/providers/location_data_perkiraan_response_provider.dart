import 'package:get/get.dart';

import '../../constants.dart';
import '../models/location_data_perkiraan_response_model.dart';

class LocationDataPerkiraanResponseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return LocationDataPerkiraanResponse.fromJson(map);
      }
      if (map is List) {
        return map
            .map((item) => LocationDataPerkiraanResponse.fromJson(item))
            .toList();
      }
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<List<LocationDataPerkiraanResponse?>> getLocationDataPerkiraanResponse(
      String remark) async {
    final response = await get('perkiraan?remarks=${remark}');
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
