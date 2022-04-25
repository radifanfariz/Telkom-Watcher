import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';
import 'package:trackernity_watcher/app/modules/home/views/helpers/responsiveness.dart';

import 'tabview1.dart';
import 'tabview2.dart';

class SheetComponent extends GetView<HomeController>{

  SheetComponent._internal();

  static final SheetComponent _sheetComponent = SheetComponent._internal();

  factory SheetComponent(){
    return _sheetComponent;
  }

  late String changeUrlStr;

  Widget _sheetContent(
      BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        controller: (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android)
            ? controller.scrollController
            : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context)) ? topMostWidgetLargeScreen(context) : topMostWidgetSmallScreen(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.white,
                          indicatorColor: Colors.redAccent,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          controller: controller.tabController,
                          tabs: controller.myTabs,
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        TabView1(scrollController:controller.scrollController),
                        TabView2(scrollController:controller.scrollController),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _sheetContent(context);
  }

  Widget topMostWidgetSmallScreen(){
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 5,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10)),
      ),
      onTap: () => {
        controller.panelController.isPanelOpen
            ? controller.panelController.close()
            : controller.panelController.open()
      },
    );
  }

  Widget topMostWidgetLargeScreen(BuildContext context){
      return Text("Web Version",
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Dongle',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
  }

  // Widget topMostWidgetLargeScreen(BuildContext context){
  //   return Obx((){
  //     return GestureDetector(
  //         onTap: () =>
  //             Get.defaultDialog(
  //                 title: "Change API Url",
  //                 titleStyle: TextStyle(fontSize: 25),
  //                 content: TextField(
  //                     keyboardType: TextInputType.text,
  //                     style: Theme
  //                         .of(context)
  //                         .textTheme
  //                         .headline6,
  //                     decoration: InputDecoration(
  //                         labelText: "Enter a new API url",
  //                         border: const OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(
  //                               Radius.circular(10)),
  //                         )),
  //                     onChanged: (value) {
  //                       changeUrlStr = value;
  //                     }
  //                 ),
  //                 textCancel: "Cancel",
  //                 textConfirm: "Confrim",
  //                 onConfirm: () {
  //                   HomeController.baseUrl.value = changeUrlStr;
  //                   print(HomeController.baseUrl.value);
  //                   Get.back();
  //                 }
  //             ),
  //         child:
  //         Container(
  //           margin: EdgeInsets.only(top: 20),
  //           height: 20,
  //           width: double.infinity,
  //           color: Colors.black,
  //           alignment: Alignment.center,
  //           child: Text("API_url: ${HomeController.baseUrl.value} ",
  //             style: TextStyle(
  //               fontSize: 12,
  //               fontFamily: 'Consolas',
  //               fontWeight: FontWeight.bold,
  //               color: const Color(0xff008000),
  //             ),
  //           ),
  //         )
  //     );
  //   });
  // }

}