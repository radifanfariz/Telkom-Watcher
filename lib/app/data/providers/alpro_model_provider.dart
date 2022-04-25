import 'package:get/get.dart';
import 'package:trackernity_watcher/app/constants.dart';

import '../models/alpro_model.dart';

class AlproModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return AlproModel.fromJson(map);
      if (map is List)
        return map.map((item) => AlproModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = '${ConstantClass.baseUrlConstant}/api/trackernity/';
  }

  Future<List<AlproModel?>> getAlproModel(String remark) async {
    final response = await get('alpro?remarks=$remark');
    return response.body;
  }

  Future<List<AlproModel?>> getAlproModelSecond(String remark,String treg, String witel) async {
    final response = await get('alpro-second?remarks=$remark&treg=$treg&witel=$witel');
    return response.body;
  }

  Future<List<AlproModel?>> getAlproModelThird(String remark,String treg, String witel, String route) async {
    final response = await get('alpro-third?remarks=$remark&treg=$treg&witel=$witel&descriptions=$route');
    return response.body;
  }

  // Future<List<AlproModel?>> getAlproGangguanModel(String remark) async {
  //   final response = await get('gangguan?remarks=$remark');
  //   return response.body;
  // }

  // Future<Response<AlproModel>> postAlproModel(AlproModel alpromodel) async =>
  //     await post('alpromodel', alpromodel);
  // Future<Response> deleteAlproModel(int id) async =>
  //     await delete('alpromodel/$id');
}
