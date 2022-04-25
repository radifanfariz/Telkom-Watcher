import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackernity_watcher/app/constants.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/google_maps_component.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/sheet_component.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/slidingup_panel_component.dart';

import '../components/tabview1.dart';
import '../components/tabview2.dart';

class SmallScreenWidget extends GetView<HomeController>{

  SmallScreenWidget._internal();

  static final SmallScreenWidget _smallScreenWidget = SmallScreenWidget._internal();

  factory SmallScreenWidget(){
    return _smallScreenWidget;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Stack(
        children: [
          GoogleMapsWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 2,left: 5),
            child: Obx(
              () {
                return InputChip(
                  avatar: const Icon(Icons.account_circle),
                  label: Text(controller.loginUserId.value),
                  onPressed: (){
                    Get.defaultDialog(
                        title: "Log Out",
                        titleStyle: TextStyle(fontSize: 25),
                        content: Text("Are you sure want to Log Out?"),
                        textCancel: "No",
                        textConfirm: "Yes",
                        buttonColor: Colors.red,
                        confirmTextColor: Colors.black,
                        cancelTextColor: Colors.black,
                        onConfirm: () {
                          controller.removeSharedPreferences().then((value){
                            if(value){
                              GoogleMapsWidget.googleMapController.dispose();
                              ConstantClass.showToast("Log Out !");
                              Get.offAllNamed('/login');
                            }else{
                              GoogleMapsWidget.googleMapController.dispose();
                              ConstantClass.showToast("Something went wrong !");
                              Get.offAllNamed('/login');
                            }
                          },onError: (err) => ConstantClass.showToast("Error !"));
                        }
                    );
                  },
                );
              }
            ),
          ),
          SlidingUpPanelWidget(),
      CustomInfoWindow(
        controller: controller.customInfoWindowController,
        height: 100,
        width: 250,
        offset: 10,
      ),
        ],
      ),
    );
  }

}