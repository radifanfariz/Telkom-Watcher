import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:trackernity_watcher/app/data/socket/socket_initiate.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/components_utils.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/google_maps_component.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/socket_component.dart';
import 'package:trackernity_watcher/app/modules/home/views/helpers/responsiveness.dart';

/* if we want render different listview */
// enum verticalListviewContentEnum{
//   SURFACE,
//   DETAIL
// }

class TabView1 extends GetView<HomeController> {
  late BuildContext context;

  late ScrollController _scrollController;
  late TextEditingController _textEditingController;
  late DateTime _selectedDate;

  var _toggleSwitch = true.obs;

  var _buttonConnectLabel = "Disconnect".obs;
  var _indicatorConnectColor = Colors.green.obs;

  /* if we want render different listview */
  // var verticalListviewContent = verticalListviewContentEnum.SURFACE.obs;

  TabView1({Key? key, required ScrollController scrollController})
      : super(key: key) {
    _scrollController = scrollController;
  }

  ///////////////////////widget function////////////////////

  Widget _searchTextField() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: TextField(
                onChanged: (text) {
                  controller.userId.value = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "User Id",
                    hintText: (controller.userId.value.isNotEmpty) ? controller
                        .userId.value : "user id",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                ),
              ),
            ),
            // SizedBox(
            //   width: 30,
            // ),
            // Flexible(
            //   child: TextField(
            //     onChanged: (text){
            //       controller.remark.value = text;
            //     },
            //     keyboardType: TextInputType.text,
            //     decoration: InputDecoration(
            //         labelText: (controller.remark.value.isNotEmpty) ? controller.remark.value : "remark",
            //         border: const OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10))
            //         )
            //     ),
            //   ),
            // ),
          ]),
    );
  }

  Widget _dateTextField() {
    return Obx(
            () {
          return Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ Flexible(
                  child: TextField(
                    focusNode: AlwaysDisableFocusNode(),
                    onTap: () {
                      ComponentUtils.showCupertinoSheet(
                        context,
                        child: _cupertinoDatePickerDialogStart(),
                        onClicked: () {
                          // print(controller.dateTimeStart.value);
                          Get.back();
                        }
                        ,
                      );
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "${controller.dateFormat.format(
                            controller.dateTimeStart.value)}",
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )
                    ),
                  ),
                ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 20,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: TextField(
                      focusNode: AlwaysDisableFocusNode(),
                      onTap: () {
                        ComponentUtils.showCupertinoSheet(
                          context,
                          child: _cupertinoDatePickerDialogEnd(),
                          onClicked: () {
                            // print(controller.dateTimeStart.value);
                            Get.back();
                          }
                          ,
                        );
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "${controller.dateFormat.format(
                              controller.dateTimeEnd.value)}",
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10))
                          )
                      ),
                    ),
                  ),
                ]),
          );
        }
    );
  }

  Widget _expandableContent() {
    return Obx(() {
      return ExpansionPanelList(
        children: [
          ExpansionPanel(headerBuilder: (context, isOpen) {
            return Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text("Location History",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,),
            );
          },
            isExpanded: controller.isExpanded.value,
            body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(
                          () {
                        return _searchTextField();
                      }
                  ),
                  _dateTextField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        late String stringDateTimeStart = controller
                            .dateFormat.format(
                            controller.dateTimeStart.value);
                        late String stringDateTimeEnd = controller.dateFormat
                            .format(controller.dateTimeEnd.value);
                        controller.getTrackingHistoryData(
                            userId: controller.userId.value,
                            remark: controller.remark.value,
                            dateStart: stringDateTimeStart,
                            dateEnd: stringDateTimeEnd);
                      },
                      child: Text("Search"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        expansionCallback: (item, bool status) {
          controller.isExpanded(!controller.isExpanded.value);
          // print(controller.isExpanded.value);
        },
      );
    }
    );
  }

  /*   vertical listview  */

  Widget _verticalListView() {
    return Flexible(
      flex: 6,
      fit: FlexFit.tight,
      child: Obx(
              () {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10),
                  controller: (defaultTargetPlatform == TargetPlatform.iOS ||
                      defaultTargetPlatform == TargetPlatform.android)
                      ? _scrollController
                      : null,
                  itemCount: controller.dataLocationHistory.value.data != null ?
                  controller.dataLocationHistory.value.data?.length : 0,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return InkWell(
                      onTap: () {
                        /* if we want render different listview */
                        // verticalListviewContent.value = verticalListviewContentEnum.DETAIL;
                        if (controller.polyLine1 != null) {
                          controller.removePolylines(controller.polyLine1);
                          controller.removeMarkers(controller.currentMarkers);
                        }
                        _removePreviousTabViewMarkers();
                        var token = controller.dataLocationHistory.value
                            .data?[index].token;
                        // print("Token Variable: ${token}");
                        controller.getTrackingHistoryDetailData(token: token!)
                            .then((_) {
                          if (!ResponsiveWidget.isLargeScreen(context) &&
                              !ResponsiveWidget.isMediumScreen(context)) {
                            if (controller.panelController.isAttached) {
                              controller.panelController.close();
                            }
                            // print("Print me if close");
                          }
                        }
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(
                          "Id :${controller.dataLocationHistory.value
                              .data?[index].id}"
                              "\n"
                              "UserId: ${controller.dataLocationHistory.value
                              .data?[index].userId}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text("DateTime: ${controller
                            .dataLocationHistory.value.data?[index]
                            .date_time}"),
                      ),
                    );
                  },
                ),
              ),
            );
          }
      ),
    );
  }

  /*   horizontal listview  */

  Widget _horizontalListview() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Obx(() {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.only(top: 5, right: 5),
                    decoration: BoxDecoration(
                        color: _indicatorConnectColor.value,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  );
                }
                ),
                Obx(
                        () {
                      return OutlinedButton(
                        onPressed: () {
                          if (_buttonConnectLabel.value == "Disconnect") {
                            disconnectSocket(() {
                              controller.namaConnectedSet.clear();
                              controller.userIdConnectedSet.clear();
                              controller.latLngListPolylines.clear();
                              controller.markers.clear();
                              controller.polylines.clear();
                            });
                            _buttonConnectLabel.value = "Connect";
                            _indicatorConnectColor.value = Colors.red;
                          } else {
                            connectSocket(() {});
                            _buttonConnectLabel.value = "Disconnect";
                            _indicatorConnectColor.value = Colors.green;
                          }
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith((
                              states) {
                            if (states.contains(MaterialState.hovered)) {
                              if (_buttonConnectLabel.value == "Disconnect") {
                                return Colors.red;
                              } else {
                                return Colors.green;
                              }
                            }
                            return Colors.transparent;
                          }),
                        ),
                        child: Text(_buttonConnectLabel.value, style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),),
                      );
                    }
                ),
              ],
            ),
            Obx(() {
              return Switch(
                  value: _toggleSwitch.value,
                  onChanged: (value) {
                    _toggleSwitch.value = value;
                    controller.isAddPolylinesActive.value = value;
                    // controller.isShowMarkerAndPolylines(value);
                    if (value == false) {
                      socket.disconnect();
                      for (var item in controller.latLngListPolylines) {
                        controller.latLngListPolylinesCache.add(item);
                      }
                      controller.latLngListPolylines.clear();
                      socket.connect();
                    } else {
                      socket.disconnect();
                      for (var item in controller.latLngListPolylinesCache) {
                        controller.latLngListPolylines.add(item);
                      }
                      controller.latLngListPolylinesCache.clear();
                      socket.connect();
                    }
                  }
              );
            }),
          ],
        ),
        Expanded(
          child: BuildWithSocketStream(
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  var cProfile = snapshot.data?.cProfile;
                  log("Test c_profile: ${controller.cProfile.value}");
                  if (cProfile == controller.cProfile.value) {
                    var userId = snapshot.data?.userId;
                    var nama = snapshot.data?.nama;
                    controller.namaConnectedSet.value.add(nama!);
                    controller.userIdConnectedSet.value.add(
                        userId!);
                  }
                  // controller.connectedUser.add(userId);
                  // controller.idleUser.add(userId);
                  // controller.disconnectListMechanism(userId);
                  // print("test set: ${controller.userIdConnectedSet.value}");
                  // print("test list: ${controller.idleUser.length}");
                }
                return Obx(
                        () {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 10),
                            controller: (defaultTargetPlatform ==
                                TargetPlatform.iOS ||
                                defaultTargetPlatform == TargetPlatform.android)
                                ? _scrollController
                                : null,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.userIdConnectedSet.isNotEmpty
                                ? controller.userIdConnectedSet.length
                                : 0,
                            itemBuilder: (context, index) =>
                                SizedBox(
                                  width: 120,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.polyLine1 != null) {
                                        controller.removePolylines(
                                            controller.polyLine1);
                                      }
                                      controller.userId.value =
                                          controller.userIdConnectedSet
                                              .elementAt(index);
                                      GoogleMapsWidget.cameraToUser(
                                          controller.latLng.value);
                                      if (!ResponsiveWidget.isLargeScreen(
                                          context) &&
                                          !ResponsiveWidget.isMediumScreen(
                                              context)) {
                                        if (controller.panelController
                                            .isAttached) {
                                          controller.panelController.close();
                                        }
                                        // print("Print me if close");
                                      }
                                      // _showToast(
                                      //     context, "Test Titlle", "Test Message");
                                    },
                                    child: InkWell(
                                      child: Card(
                                        color: Colors.redAccent,
                                        margin: EdgeInsets.all(8),
                                        child:
                                        Center(
                                          child:
                                          Text(
                                            "${controller.namaConnectedSet
                                                .elementAt(index)}\n${controller.userIdConnectedSet
                                                .elementAt(index)}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ),
                      );
                    }
                );
              }
          ),
        ),
      ],
    );
  }

  Widget _cupertinoDatePickerDialogStart() {
    return SizedBox(
      height: 100,
      child: CupertinoDatePicker(
          initialDateTime: controller.dateTimeStart.value,
          maximumYear: DateTime
              .now()
              .year,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            controller.dateTimeStart.value = dateTime;
          }),
    );
  }

  Widget _cupertinoDatePickerDialogEnd() {
    return SizedBox(
      height: 100,
      child: CupertinoDatePicker(
          initialDateTime: controller.dateTimeEnd.value,
          maximumYear: DateTime
              .now()
              .year,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            controller.dateTimeEnd.value = dateTime;
          }),
    );
  }

  Widget _errorState() {
    return Flexible(
      flex: 6,
      child: Image.asset('assets/images/image_error_404.jpg'),
    );
  }

  Widget _noDataState() {
    return Flexible(
      flex: 6,
      child: Image.asset('assets/images/image_no_data.jpg'),
    );
  }

  //////////////////build widget function///////////////////////////

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              flexibleSpace: _horizontalListview(),
              backgroundColor: Colors.transparent,
            ),
            SliverFillRemaining(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _expandableContent(),
                    Obx(
                            () {
                          return Visibility(
                              visible: controller.isLoading.value,
                              child: LinearProgressIndicator()
                          );
                        }
                    ),
                    Obx(
                            () {
                          if (controller.isError.value == true) {
                            return _errorState();
                          } else if (controller.isNoData.value == true) {
                            return _noDataState();
                          }
                          else {
                            return _verticalListView();
                          }
                        }
                    ),
                    /* if we want update listview content */
                    // Obx(
                    //   () {
                    //     /* if we want render different listview */
                    //     // switch(verticalListviewContent.value){
                    //     //   case verticalListviewContentEnum.SURFACE:{
                    //     //     return _verticalListView();
                    //     //   }
                    //     //   case verticalListviewContentEnum.DETAIL:{
                    //     //     return _horizontalListview();
                    //     //   }
                    //     // }
                    //     return _verticalListView();
                    //   }
                    // ),
                  ]),
            )
          ]),
    );
  }

  //////////////////////regular functions//////////////

  void _removePreviousTabViewMarkers() {
    log("Called Build for TabView 1");
    if (controller.currentMarkersAlpro.isNotEmpty) {
      controller.removeMarkers(controller.currentMarkersAlpro);
      controller.removePolylines(controller.currentPolylineAlpro);
    }
    if (controller.currentMarkers.isNotEmpty) {
      controller.removeMarkers(controller.currentMarkers);
    }
  }

  // void _showToast(BuildContext context, String title, String message) {
  //   Get.defaultDialog(
  //     title: title,
  //     titleStyle: TextStyle(fontSize: 25),
  //     middleText: message,
  //     middleTextStyle: TextStyle(fontSize: 20),
  //   );
  // }

  Future<void> _refresh() async {
    // await Future.delayed(Duration(seconds: 10));
    late String stringDateTimeStart = controller
        .dateFormat.format(
        controller.dateTimeStart.value);
    late String stringDateTimeEnd = controller.dateFormat
        .format(controller.dateTimeEnd.value);
    controller.getTrackingHistoryData(
        userId: controller.userId.value,
        remark: controller.remark.value,
        dateStart: stringDateTimeStart,
        dateEnd: stringDateTimeEnd);
  }

  _selectDatePicker(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                  primary: Colors.redAccent,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.white
              ),
              dialogBackgroundColor: Colors.grey
          ), child: child as Widget);
        }
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream
        ));
    }
  }


}

class AlwaysDisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}