import 'package:get/get.dart';
import 'package:trackernity_watcher/app/constants.dart';

import '../models/tracking_history_model.dart';

class TrackingHistoryModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>)
        return TrackingHistoryModel.fromJson(map);
      if (map is List)
        return map.map((item) => TrackingHistoryModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<TrackingHistoryModel?> getTrackingHistoryModel({required String userId,String remark = "", required String dateStart, required String dateEnd}) async {
    final response = await get('tracking-history?user_id=${userId}&remarks=${remark}&date_start=${dateStart}&date_end=${dateEnd}');
    print("response: ${response.request?.url}");
    return response.body;
  }

  Future<Response<TrackingHistoryModel>> postTrackingHistoryModel(
          TrackingHistoryModel trackinghistorymodel) async =>
      await post('trackinghistorymodel', trackinghistorymodel);
  Future<Response> deleteTrackingHistoryModel(int id) async =>
      await delete('trackinghistorymodel/$id');
}
