import 'package:get/get.dart';
import 'package:trackernity_watcher/app/constants.dart';

import '../models/tracking_history_detail_model.dart';

class TrackingHistoryDetailModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>)
        return TrackingHistoryDetailModel.fromJson(map);
      if (map is List)
        return map
            .map((item) => TrackingHistoryDetailModel.fromJson(item))
            .toList();
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<TrackingHistoryDetailModel?> getTrackingHistoryDetailModel({required String token}) async {
    final response = await get('tracking-history-detail?token=${token}');
    return response.body;
  }

  Future<Response<TrackingHistoryDetailModel>> postTrackingHistoryDetailModel(
          TrackingHistoryDetailModel trackinghistorydetailmodel) async =>
      await post('trackinghistorydetailmodel', trackinghistorydetailmodel);
  Future<Response> deleteTrackingHistoryDetailModel(int id) async =>
      await delete('trackinghistorydetailmodel/$id');
}
