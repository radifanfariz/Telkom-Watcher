import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/google_maps_component.dart';
import 'package:trackernity_watcher/app/modules/home/views/dialogview_view.dart';
import 'package:trackernity_watcher/app/modules/home/views/helpers/responsiveness.dart';

class TabView2 extends GetView<HomeController> {
  late ScrollController _scrollController;

  // late TextEditingController _textEditingController;
  TabView2({Key? key, required ScrollController scrollController})
      : super(key: key) {
    _scrollController = scrollController;
  }

  // List<DropdownMenuItem<String>> get dropdownItems{
  //   List<DropdownMenuItem<String>> menuItems = [
  //     const DropdownMenuItem(child: Text("USA"),value:"USA"),
  //     const DropdownMenuItem(child: Text("Canada"),value:"Canada"),
  //     const DropdownMenuItem(child: Text("Brazil"),value:"Brazil"),
  //     const DropdownMenuItem(child: Text("England"),value:"England"),
  //   ];
  //       return menuItems;
  // }

  var _isFirstChipChecked = true.obs;
  var _isSecondChipChecked = false.obs;
  var _isThirdChipChecked = false.obs;

  var _isReverse = false.obs;

  Widget _searchAlproTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // const Text(
        //   "Location Alpro",
        //   style: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        Obx(
          () {
            return ExpansionPanelList(
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        "Location Alpro",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                  isExpanded: controller.isExpanded2.value,
                  body: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Obx(() {
                                return FilterChip(
                                  label: const Text("Alpro"),
                                  selected: _isFirstChipChecked.value,
                                  onSelected: (bool value) {
                                    if (_isSecondChipChecked.value == true) {
                                      _isSecondChipChecked.value =
                                          !_isSecondChipChecked.value;
                                    }
                                    if (_isThirdChipChecked.value == true) {
                                      _isThirdChipChecked.value =
                                          !_isThirdChipChecked.value;
                                    }
                                    if (_isFirstChipChecked.value == false) {
                                      _isFirstChipChecked.value =
                                          !_isFirstChipChecked.value;
                                    }
                                    if (controller.currentMarkersAlpro.isNotEmpty) {
                                      controller.removeMarkers(
                                          controller.currentMarkersAlpro);
                                      controller.removePolylines(
                                          controller.currentPolylineAlpro);
                                    }
                                    constructRemarksParam();
                                    controller.getAlpro(controller.remark_2.value,
                                        controller.treg.value, controller.witel.value,controller.route.value);
                                  },
                                );
                              }),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Obx(() {
                                return FilterChip(
                                  label: const Text("Perkiraan Gagguan"),
                                  selected: _isThirdChipChecked.value,
                                  onSelected: (bool value) {
                                    constructRemarksParam();
                                    if (_isFirstChipChecked.value == true) {
                                      _isFirstChipChecked.value =
                                          !_isFirstChipChecked.value;
                                    }
                                    if (_isSecondChipChecked.value == true) {
                                      _isSecondChipChecked.value =
                                          !_isSecondChipChecked.value;
                                    }
                                    if (_isThirdChipChecked.value == false) {
                                      _isThirdChipChecked.value =
                                          !_isThirdChipChecked.value;
                                    }
                                    if (controller.currentMarkers.isNotEmpty) {
                                      controller
                                          .removeMarkers(controller.currentMarkers);
                                    }
                                    controller.remark_2.value =
                                        "${controller.remarkFrom.value}-${controller.remarkTo.value}";
                                    controller
                                        .getAlproPerkiraan(controller.remark_2.value);
                                  },
                                );
                              }),
                            ),
                            Obx(() {
                              return FilterChip(
                                label: const Text("Gangguan"),
                                selected: _isSecondChipChecked.value,
                                onSelected: (bool value) {
                                  if (_isFirstChipChecked.value == true) {
                                    _isFirstChipChecked.value =
                                        !_isFirstChipChecked.value;
                                  }
                                  if (_isThirdChipChecked.value == true) {
                                    _isThirdChipChecked.value =
                                        !_isThirdChipChecked.value;
                                  }
                                  if (_isSecondChipChecked.value == false) {
                                    _isSecondChipChecked.value =
                                        !_isSecondChipChecked.value;
                                  }
                                  if (controller.currentMarkers.isNotEmpty) {
                                    controller.removeMarkers(controller.currentMarkers);
                                  }
                                  controller.remark_2.value =
                                      "${controller.remarkFrom.value}-${controller.remarkTo.value}";
                                  controller
                                      .getAlproGangguan(controller.remark_2.value);
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Visibility(
                            visible: controller.isLoadingDropdown.value,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            ));
                      }),
                      Obx(() {
                        return Visibility(
                          visible: !controller.isLoadingDropdown.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Obx(() {
                              if (true) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Visibility(
                                      visible: _isFirstChipChecked.value,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 15.0),
                                              child: DropdownButtonFormField(
                                                isExpanded: true,
                                                onChanged: (text) {
                                                  controller.treg.value = text.toString();
                                                  controller.getDropDownItemsWitel(
                                                      controller.treg.value);
                                                  // log("Test OnChanged Dropdown: ${text.toString()}");
                                                },
                                                value: (controller.treg.value != "")
                                                    ? controller.treg.value
                                                    : null,
                                                style: Theme.of(context).textTheme.headline6,
                                                decoration: const InputDecoration(
                                                    labelText: "Treg",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10)),
                                                    )),
                                                items: controller.menuItemTregs,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: DropdownButtonFormField(
                                                isExpanded: true,
                                                onChanged: (text) {
                                                  controller.witel.value = text.toString();
                                                  controller.getDropdownItemsRemark(
                                                      controller.treg.value,
                                                      controller.witel.value);
                                                  // log("Test OnChanged Dropdown: ${text.toString()}");
                                                },
                                                value: (controller.witel.value != "")
                                                    ? controller.witel.value
                                                    : null,
                                                style: Theme.of(context).textTheme.headline6,
                                                decoration: const InputDecoration(
                                                    labelText: "Witel",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10)),
                                                    )),
                                                items: controller.menuItemWitels,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            child: DropdownButtonFormField(
                                              isExpanded: true,
                                              onChanged: (text) {
                                                controller.remarkFrom.value = text.toString();
                                                // log("Test OnChanged Dropdown: ${text.toString()}");
                                              },
                                              value: (controller.remarkFrom.value != "")
                                                  ? controller.remarkFrom.value
                                                  : null,
                                              style: Theme.of(context).textTheme.headline6,
                                              decoration: const InputDecoration(
                                                  labelText: "From",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10)),
                                                  )),
                                              items: controller.menuItemsRemarks,
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
                                            child: DropdownButtonFormField(
                                              isExpanded: true,
                                              onChanged: (text) {
                                                controller.remarkTo.value = text.toString();
                                                constructRemarksParam();
                                                controller.getDropDownItemsRoutes(
                                                    controller.treg.value,
                                                    controller.witel.value,
                                                    controller.remark_2.value,
                                                );
                                                // log("Test OnChanged Dropdown: ${text.toString()}");
                                              },
                                              value: (controller.remarkTo.value != "")
                                                  ? controller.remarkTo.value
                                                  : null,
                                              style: Theme.of(context).textTheme.headline6,
                                              decoration: const InputDecoration(
                                                  labelText: "To",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10)),
                                                  )),
                                              items: controller.menuItemsRemarks,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isFirstChipChecked.value,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: DropdownButtonFormField(
                                          isExpanded: true,
                                          onChanged: (text) {
                                            controller.route.value = text.toString();
                                            // log("Test OnChanged Dropdown: ${text.toString()}");
                                          },
                                          value: (controller.route.value != "")
                                              ? controller.route.value
                                              : null,
                                          style: Theme.of(context).textTheme.headline6,
                                          decoration: const InputDecoration(
                                              labelText: "Route",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(10)),
                                              )),
                                          items: controller.menuItemRoutes,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Flexible(
                                        child: Text(
                                          "Something went wrong !!!",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          // controller.getDropdownItems();
                                          controller.getDropDownItemsTreg();
                                        },
                                        child: const Text("Refresh"))
                                  ],
                                );
                              }
                            }),
                          ),
                        );
                      }),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  constructRemarksParam();
                                  if (_isFirstChipChecked.value == true) {
                                    /////legacy code /////////
                                    // if (controller.remarkFrom.value != "" &&
                                    //     controller.remarkTo.value != "") {
                                    //   DialogviewView.dialogViewAlpro(context, controller);
                                    // }
                                    if (controller.currentMarkersAlpro.isNotEmpty) {
                                      controller
                                          .removeMarkers(controller.currentMarkersAlpro);
                                      controller
                                          .removePolylines(controller.currentPolylineAlpro);
                                    }
                                    controller.getAlpro(controller.remark_2.value,
                                        controller.treg.value, controller.witel.value, controller.route.value);
                                  } else if (_isSecondChipChecked.value == true) {
                                    if (controller.currentMarkers.isNotEmpty) {
                                      controller.removeMarkers(controller.currentMarkers);
                                    }
                                    controller.getAlproGangguan(controller.remark_2.value);
                                  } else {
                                    if (controller.currentMarkers.isNotEmpty) {
                                      controller.removeMarkers(controller.currentMarkers);
                                    }
                                    controller.getAlproPerkiraan(controller.remark_2.value);
                                  }
                                  if (!ResponsiveWidget.isLargeScreen(context) &&
                                      !ResponsiveWidget.isMediumScreen(context)) {
                                    if (controller.panelController.isAttached) {
                                      controller.panelController.close();
                                    }
                                  }
                                  // print("Data Result API: ${controller.dataAlpro.last?.userId}");
                                },
                                child: const Text("Search"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
              expansionCallback: (item, bool status) {
                controller.isExpanded2(!controller.isExpanded2.value);
                // print(controller.isExpanded2.value);
              },
            );
          }
        ),
        Obx(() {
          return Visibility(
              visible: controller.isLoading.value,
              child: const LinearProgressIndicator(
                color: Colors.green,
              ));
        }),
        Obx(() {
          if (controller.isError2.value == true) {
            return _errorState();
          } else {
            return Flexible(flex: 8, child: _alproListView());
          }
        }),
      ],
    );
  }

  Widget _alproListView() {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
            reverse: _isReverse.value,
            shrinkWrap: true,
            controller: (defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.android)
                ? _scrollController
                : null,
            itemCount: (_isThirdChipChecked.value == true)
                ? controller.dataPerkiraan.length
                : (_isSecondChipChecked.value == true)
                    ? controller.dataGangguan.length
                    : controller.dataAlpro.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    // constructRemarksParam(); /////optional
                    _removePreviousTabViewPolyline();
                    if (_isFirstChipChecked.value == true) {
                      if (!controller.markers
                          .containsAll(controller.currentMarkersAlpro)) {
                        controller.getAlpro(controller.remark_2.value,
                            controller.treg.value, controller.witel.value, controller.route.value);
                      }
                      GoogleMapsWidget.cameraToUser(controller
                          .currentMarkersAlpro
                          .elementAt(index)
                          .position);
                      if (defaultTargetPlatform == TargetPlatform.iOS ||
                          defaultTargetPlatform == TargetPlatform.android) {
                        controller.currentMarkersAlpro
                            .elementAt(index)
                            .onTap!();
                      } else {
                        GoogleMapsWidget.googleMapController
                            .showMarkerInfoWindow(controller.currentMarkersAlpro
                                .elementAt(index)
                                .markerId);
                      }
                    } else {
                      if (!controller.markers
                          .containsAll(controller.currentMarkers)) {
                        if (_isSecondChipChecked.value == true) {
                          controller
                              .getAlproGangguan(controller.remark_2.value);
                        } else {
                          controller
                              .getAlproPerkiraan(controller.remark_2.value);
                        }
                      }
                      GoogleMapsWidget.cameraToUser(
                          controller.currentMarkers.elementAt(index).position);
                      GoogleMapsWidget.googleMapController.showMarkerInfoWindow(
                          controller.currentMarkers.elementAt(index).markerId);
                      if (defaultTargetPlatform == TargetPlatform.iOS ||
                          defaultTargetPlatform == TargetPlatform.android) {
                        controller.currentMarkers.elementAt(index).onTap!();
                      } else {
                        GoogleMapsWidget.googleMapController
                            .showMarkerInfoWindow(controller.currentMarkers
                                .elementAt(index)
                                .markerId);
                      }
                    }
                    if (!ResponsiveWidget.isLargeScreen(context) ||
                        !ResponsiveWidget.isMediumScreen(context)) {
                      if (controller.panelController.isAttached) {
                        controller.panelController.close();
                      }
                    }
                  },
                  child: Obx(() {
                    return _listContents(index);
                  }),
                )),
      );
    });
  }

  Widget _listContents(var index) {
    if (_isThirdChipChecked.value == true) {
      return ListTile(
        leading: const Icon(Icons.history),
        title: Text(
          "${controller.dataPerkiraan[index]?.userId}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text.rich(TextSpan(
            text: "${controller.dataPerkiraan[index]?.remarks}\n"
                "${controller.dataPerkiraan[index]?.remarks2}",
            children: [
              TextSpan(
                  text:
                      "\n${controller.dataPerkiraan[index]?.perkiraanJarakGangguan} m",
                  style: const TextStyle(
                    color: Colors.blue,
                  ))
            ])),
      );
    } else if (_isSecondChipChecked.value == true) {
      return ListTile(
        leading: const Icon(Icons.history),
        title: Text(
          "${controller.dataGangguan[index]?.userId}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${controller.dataGangguan[index]?.remarks}\n"
            "${controller.dataGangguan[index]?.remarks2}"),
      );
    } else {
      return ListTile(
        leading: const Icon(Icons.history),
        title: Text(
          "${controller.dataAlpro[index]?.id}\n"
          "${controller.dataAlpro[index]?.userId}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${controller.dataAlpro[index]?.remarks}\n"
            "${controller.dataAlpro[index]?.descriptions}"),
      );
    }
  }

  Widget _errorState() {
    return Flexible(
      flex: 2,
      child: Image.asset('assets/images/image_error_404.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    /////legacy code//////////////////
    // if (!ResponsiveWidget.isLargeScreen(context) &&
    //     !ResponsiveWidget.isMediumScreen(context)) {
    //   controller.markerIcon =
    //       BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    //   // controller.markerIcon = controller.bitmapImage2;
    // } else {
    //   controller.markerIcon = controller.bitmapImage2;
    // }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: _searchAlproTextField(context),
    );
  }

  void _removePreviousTabViewPolyline() {
    if (controller.polyLine1 != null) {
      controller.removePolylines(controller.polyLine1);
    }
  }

  Future<void> _refresh() async {
    // await Future.delayed(Duration(seconds: 5));
    // constructRemarksParam(); ////optional
    if (_isFirstChipChecked.value == true) {
      if (controller.currentMarkersAlpro.isNotEmpty) {
        controller.removeMarkers(controller.currentMarkersAlpro);
        controller.removePolylines(controller.currentPolylineAlpro);
      }
      controller.getAlpro(controller.remark_2.value, controller.treg.value,
          controller.witel.value,controller.route.value);
    } else if (_isSecondChipChecked.value == true) {
      if (controller.currentMarkers.isNotEmpty) {
        controller.removeMarkers(controller.currentMarkers);
      }
      controller.getAlproGangguan(controller.remark_2.value);
    } else {
      if (controller.currentMarkers.isNotEmpty) {
        controller.removeMarkers(controller.currentMarkers);
      }
      controller.getAlproPerkiraan(controller.remark_2.value);
    }
  }

  void constructRemarksParam() {
    if (_isFirstChipChecked.value == true) {
      if (controller.headList.contains(controller.remarkFrom.value)) {
        controller.remark_2.value =
            "${controller.remarkFrom.value}-${controller.remarkTo.value}";
        _isReverse(false);
      } else {
        controller.remark_2.value =
            "${controller.remarkTo.value}-${controller.remarkFrom.value}";
        _isReverse(true);
      }
    } else {
      controller.remark_2.value =
          "${controller.remarkFrom.value}-${controller.remarkTo.value}";
      _isReverse(false);
    }
  }
}
