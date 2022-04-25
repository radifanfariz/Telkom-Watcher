import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:trackernity_watcher/app/data/models/location_data_realtime_model.dart';
import 'package:trackernity_watcher/app/data/socket/socket_initiate.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';

class BuildWithSocketStream extends GetView<HomeController> {
  final Widget Function(BuildContext, AsyncSnapshot<LocationDataRealtime>) builder;
  const BuildWithSocketStream({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: streamSocket.getResponse ,
        builder: builder,
      ),
    );
  }
}