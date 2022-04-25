import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/google_maps_component.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/sheet_component.dart';
import 'package:trackernity_watcher/app/modules/home/views/home_view.dart';

import '../../../../constants.dart';


class LargeScreenWidget extends GetView<HomeController>{

  LargeScreenWidget._internal();

  static final LargeScreenWidget _largeScreenWidget = LargeScreenWidget._internal();

  factory LargeScreenWidget(){
    return _largeScreenWidget;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: SheetComponent(),
          ),
          Expanded(
            flex: 2,
              child: Stack(
                children: [
                  GoogleMapsWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 2,left: 5),
                    child: Obx(
                      () {
                        // log("is Value Exist : ${controller.loginUserId.value} and ${controller.cProfile.value}");
                        return InputChip(
                          avatar: Icon(Icons.account_circle),
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
                ],
              )
          )
        ],
      ),
    );
  }

}