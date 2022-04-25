import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackernity_watcher/app/data/models/dropdown_items_model.dart';
import 'package:trackernity_watcher/app/data/models/location_data_gangguan_response_model.dart';
import 'package:trackernity_watcher/app/data/models/location_data_perkiraan_response_model.dart';
import 'package:trackernity_watcher/app/data/providers/dropdown_items_provider.dart';
import 'package:trackernity_watcher/app/data/providers/dropdown_items_second_provider.dart';
import 'package:trackernity_watcher/app/data/providers/location_data_gangguan_response_provider.dart';
import 'package:trackernity_watcher/app/data/providers/location_data_perkiraan_response_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackernity_watcher/app/data/models/alpro_model.dart';
import 'package:trackernity_watcher/app/data/models/location_data_realtime_model.dart';
import 'package:trackernity_watcher/app/data/models/tracking_history_detail_model.dart';
import 'package:trackernity_watcher/app/data/models/tracking_history_model.dart';
import 'package:trackernity_watcher/app/data/providers/alpro_model_provider.dart';
import 'package:trackernity_watcher/app/data/providers/tracking_history_detail_model_provider.dart';
import 'package:trackernity_watcher/app/data/providers/tracking_history_model_provider.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/google_maps_component.dart';

import '../../../constants.dart';
import '../../../data/models/dropdown_items_second_model.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement HomeController

  // final count = 0.obs;

  late var cProfile = "".obs;

  late var loginUserId = "".obs;

  final isExpanded = false.obs;
  final isExpanded2 = true.obs;

  final myTabs  = <Tab>[
    Tab( text: "Teknisi",),
    Tab( text: "Alpro",),
  ];

  late TabController tabController;
  late ScrollController scrollController;
  late PanelController panelController;

  static var baseUrl = ConstantClass.baseUrlConstant.obs;

  var isLoading = false.obs;
  var isError = false.obs;
  var isNoData = false.obs;
  var isError2 = false.obs;

  /* location history field tabview1*/
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  late var dateTimeStart = DateTime.utc(2020,8,14).obs;
  late var dateTimeEnd = DateTime.utc(2022,8,16).obs;
  late var userId = "".obs;
  late var remark = "".obs;

  /* location history field tabview2*/
  late var remarkFrom = "".obs;
  late var remarkTo = "".obs;
  late var treg = "".obs;
  late var witel = "".obs;
  late var route = "".obs;
  late var remark_2 = "route-1".obs;

  /* variable for alpro list instantiate*/
  var uuid = Uuid();
  dynamic markerIcon;

  /* alpro_model.dart instantiate*/
  late AlproModelProvider _alproModelProvider;
  var dataAlpro = <AlproModel?>[].obs;

  void getAlpro(String remark,String treg, String witel, String route) async{
    try{
      isLoading(true);
      isError2(false);
      dataAlpro.value = await _alproModelProvider.getAlproModelThird(remark,treg,witel,route);
      late var _alproModelMap = <String,AlproModel>{};
      for(var item in dataAlpro){
        _alproModelMap[uuid.v1()] = item!;
      }
       // addPolyLinesAndGet(_listLatLng, Colors.redAccent, remark).then((value) => polyLine2 = value);
      await addMarkersAndGet(_alproModelMap, bitmapImage3).then((value) => currentMarkersAlpro = value);
      final latLngFromMarkers = currentMarkersAlpro.map((e) => e.position).toSet();
      await addPolyLinesAndGet(latLngFromMarkers, Colors.black, uuid.v1()).then((value) => currentPolylineAlpro = value);
      // print("response API getAlpro: ${dataAlpro.value.length}");
    }catch(exception){
      log("API Exception: $exception");
      isError2(true);
    }finally{
      isLoading(false);
    }
  }

  /* location_data_gangguan_response_model.dart instantiate*/
  late LocationDataGangguanResponseProvider _dataGangguanResponseProvider;
  var dataGangguan = <LocationDataGangguanResponse?>[].obs;

  void getAlproGangguan(String remark) async{
    try{
      isLoading(true);
      isError2(false);
      dataGangguan.value = await _dataGangguanResponseProvider.getLocationDataGangguanResponse(remark);
      late var _alproGangguanModelMap = <String,LocationDataGangguanResponse>{};
      for(var item in dataGangguan.value){
        _alproGangguanModelMap[uuid.v1()] = item!;
      }
      // addPolyLinesAndGet(_listLatLng, Colors.redAccent, remark).then((value) => polyLine2 = value);
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
        addMarkersAndGetDataGangguan(_alproGangguanModelMap, BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)).then((value) => currentMarkers = value);
      }else{
        addMarkersAndGetDataGangguan(_alproGangguanModelMap, BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),bitmapImage4).then((value) => currentMarkers = value);
      }
      // print("response API getAlpro: ${dataAlpro.value.length}");
    }catch(exception){
      log("API Exception: $exception");
      isError2(true);
    }finally{
      isLoading(false);
    }
  }

  /* location_data_perkiraan_response_model.dart instantiate*/
  late LocationDataPerkiraanResponseProvider _dataPerkiraanResponseProvider;
  var dataPerkiraan = <LocationDataPerkiraanResponse?>[].obs;

  void getAlproPerkiraan(String remark) async{
    try{
      isLoading(true);
      isError2(false);
      dataPerkiraan.value = await _dataPerkiraanResponseProvider.getLocationDataPerkiraanResponse(remark);
      late var _dataPerkiraanModelMap = <String,LocationDataPerkiraanResponse>{};
      for(var item in dataPerkiraan.value){
        _dataPerkiraanModelMap[uuid.v1()] = item!;
      }
      // addPolyLinesAndGet(_listLatLng, Colors.redAccent, remark).then((value) => polyLine2 = value);

      //////legacy code//////
      // addMarkersAndGetDataPerkiraan(_dataPerkiraanModelMap, markerIcon).then((value) => currentMarkers = value);

      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
        addMarkersAndGetDataPerkiraan(_dataPerkiraanModelMap, BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)).then((value) => currentMarkers = value);
      }else{
        addMarkersAndGetDataPerkiraan(_dataPerkiraanModelMap, bitmapImage2).then((value) => currentMarkers = value);
      }
      // print("response API getAlpro: ${dataAlpro.value.length}");
    }catch(exception){
      log("API Exception: $exception");
      isError2(true);
    }finally{
      isLoading(false);
    }
  }

  /* tracking_history_model.dart instantiate */

  late TrackingHistoryModelProvider _trackingHistoryModelProvider;
  var dataLocationHistory = TrackingHistoryModel().obs;

  void getTrackingHistoryData({required String userId,String remark = "", required String dateStart, required String dateEnd}) async{
    try{
      isLoading(true);
      isError(false);
      isNoData(false);
      dataLocationHistory.value = (await _trackingHistoryModelProvider.getTrackingHistoryModel(userId: userId,remark: remark,dateStart: dateStart,dateEnd: dateEnd))!;
      if(dataLocationHistory.value.data == null){
        isNoData(true);
      }
      // print("response API getLocationHistory: ${dataLocationHistory.value.status}");
    }catch(exception){
      log("API Exception: $exception");
      isError(true);
    }finally{
      isLoading(false);
    }
  }

  /* tracking_history_model.dart instantiate */

  late TrackingHistoryDetailModelProvider _trackingHistoryDetailModelProvider;
  var dataLocationHistoryDetail = TrackingHistoryDetailModel().obs;

  Future<void> getTrackingHistoryDetailData({required String token}) async{
    try{
      isLoading(true);
      isError(false);
      isNoData(false);
      dataLocationHistoryDetail.value = (await _trackingHistoryDetailModelProvider.getTrackingHistoryDetailModel(token: token))!;
      if(dataLocationHistoryDetail.value.data == null){
        isNoData(true);
      }
      var _listLatLng = <LatLng>{};
      late var _dataTrackingHistoryDetailModelMap = <String,TrackingHistoryDetailModel>{};
      for (final item in dataLocationHistoryDetail.value.data!) {
        // print("Location History Detail: Lat:${item.lat} , Lng:${item.lgt}");
        _listLatLng.add(
            LatLng(item.lat!.toDouble(), item.lgt!.toDouble()));
      }

      _dataTrackingHistoryDetailModelMap[uuid.v1()] = dataLocationHistoryDetail.value;
     addPolyLinesAndGet(_listLatLng,Colors.blueAccent, token).then((value) => polyLine1 = value);
      addMarkersAndGetTrackingHistoryDetail(_dataTrackingHistoryDetailModelMap, bitmapImage3).then((value) => currentMarkers = value);
      // print("response API getLocationHistoryDetail: ${dataLocationHistoryDetail.value.status}");
    }catch(exception){
      log("API Exception: $exception");
      isError(true);
    }finally{
      isLoading(false);
    }
  }

  /* tracking_loaction_data_realtime.dart instantiate */
  late var userIdConnectedSet = <String>{}.obs;
  late var namaConnectedSet = <String>{}.obs;
  late var locationDataRealtime = LocationDataRealtime().obs;

  late BitmapDescriptor bitmapImage;
  late BitmapDescriptor bitmapImage2;
  late BitmapDescriptor bitmapImage3;
  late BitmapDescriptor bitmapImage4;

  late var markers = <Marker>{}.obs;
  late var circles = <Circle>{}.obs ;
  late var polylines = <Polyline>{}.obs ;
  late var latLng = const LatLng(37.42796133580664, -122.085749655962).obs;
  var isShowMarkerAndPolylines = true.obs;
  dynamic polyLine1;
  late var currentMarkers = <Marker>{};
  late var currentMarkersAlpro = <Marker>{};
  late dynamic currentPolylineAlpro;
  var latLngListPolylines = <LatLng>[].obs;
  var latLngListPolylinesCache = <LatLng>[].obs;
  var isAddPolylinesActive = true.obs;
  CustomInfoWindowController customInfoWindowController =
  CustomInfoWindowController();

  Future<Polyline> addPolyLinesAndGet(Set<LatLng> listLatlng,Color color,String id) async{
    var polyLine = Polyline(
      polylineId: PolylineId(
          id),
      points: listLatlng.toList(),
      color: color,
      width: 3,
    );
    polylines.add(polyLine);
    GoogleMapsWidget.cameraToUser(listLatlng.last);
    return polyLine;
  }
  Future<Set<Marker>> addMarkersAndGet(Map<String,AlproModel> alproModelMap,BitmapDescriptor markerIcon) async{
    var localMarker = <Marker>{};
    Marker marker;
    for(var key in alproModelMap.keys){
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
        marker = Marker(
          markerId: MarkerId(
              key),
          position: LatLng(alproModelMap[key]!.lat!.toDouble(), alproModelMap[key]!.lgt!.toDouble()),
          icon: markerIcon,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Id: ${alproModelMap[key]!.id} \n"
                                  "Lat: ${alproModelMap[key]!.lat} \n"
                                  "Long: ${alproModelMap[key]!.lgt} \n"
                                  "Route: ${alproModelMap[key]!.remarks} -> ${alproModelMap[key]!.descriptions} \n",
                              style:const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.white,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(alproModelMap[key]!.lat!.toDouble(), alproModelMap[key]!.lgt!.toDouble()),
            );
          },
        );
      } else {
        marker = Marker(
          markerId: MarkerId(
              key),
          position: LatLng(alproModelMap[key]!.lat!.toDouble(), alproModelMap[key]!.lgt!.toDouble()),
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: "Id: ${alproModelMap[key]!.id} \n"
                "Lat: ${alproModelMap[key]!.lat} \n"
                "Long: ${alproModelMap[key]!.lgt} \n"
                "Route: ${alproModelMap[key]!.remarks} -> ${alproModelMap[key]!.descriptions} \n",
          )
        );
      }
      markers.add(marker);
      localMarker.add(marker);
    }
    GoogleMapsWidget.cameraToUser(LatLng(alproModelMap[alproModelMap.keys.last]!.lat!.toDouble(), alproModelMap[alproModelMap.keys.last]!.lgt!.toDouble()));
    return localMarker;
  }

  Future<Set<Marker>> addMarkersAndGetDataGangguan(Map<String,LocationDataGangguanResponse> dataGangguanModelMap,BitmapDescriptor markerIcon,BitmapDescriptor markerIcon2) async{
    var localMarker = <Marker>{};
    Marker marker;
    for(var key in dataGangguanModelMap.keys){
      // log("flagging_ggn_selesai: ${dataGangguanModelMap[key]!.flaggingGangguanSelesai}");
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
        marker = Marker(
          markerId: MarkerId(
              key),
          position: LatLng(dataGangguanModelMap[key]!.lat!.toDouble(), dataGangguanModelMap[key]!.lgt!.toDouble()),
          icon: (dataGangguanModelMap[key]!.flaggingGangguanSelesai == 0) ? markerIcon : markerIcon2,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Id: ${dataGangguanModelMap[key]!.id} \n"
                                  "Lat: ${dataGangguanModelMap[key]!.lat} \n"
                                  "Long: ${dataGangguanModelMap[key]!.lgt} \n"
                                  "Route: ${dataGangguanModelMap[key]!.remarks} ->  ${dataGangguanModelMap[key]!.remarks2} \n",
                              style:const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.white,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(dataGangguanModelMap[key]!.lat!.toDouble(), dataGangguanModelMap[key]!.lgt!.toDouble()),
            );
          },
        );
      } else {
        marker = Marker(
            markerId: MarkerId(
                key),
            position: LatLng(dataGangguanModelMap[key]!.lat!.toDouble(), dataGangguanModelMap[key]!.lgt!.toDouble()),
            icon: (dataGangguanModelMap[key]!.flaggingGangguanSelesai == 0) ? markerIcon : markerIcon2,
            infoWindow: InfoWindow(
              title: "Id: ${dataGangguanModelMap[key]!.id} \n"
                  "Lat: ${dataGangguanModelMap[key]!.lat} \n"
                  "Long: ${dataGangguanModelMap[key]!.lgt} \n"
                  "Route: ${dataGangguanModelMap[key]!.remarks} ->  ${dataGangguanModelMap[key]!.remarks2}\n",
            )
        );
      }
      markers.add(marker);
      localMarker.add(marker);
    }
    GoogleMapsWidget.cameraToUser(LatLng(dataGangguanModelMap[dataGangguanModelMap.keys.last]!.lat!.toDouble(), dataGangguanModelMap[dataGangguanModelMap.keys.last]!.lgt!.toDouble()));
    return localMarker;
  }

  Future<Set<Marker>> addMarkersAndGetDataPerkiraan(Map<String,LocationDataPerkiraanResponse> dataPerkiraanModelMap,BitmapDescriptor markerIcon) async{
    var localMarker = <Marker>{};
    Marker marker;
    for(var key in dataPerkiraanModelMap.keys){
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
        marker = Marker(
          markerId: MarkerId(
              key),
          position: LatLng(dataPerkiraanModelMap[key]!.lat!.toDouble(), dataPerkiraanModelMap[key]!.lgt!.toDouble()),
          icon: markerIcon,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Id: ${dataPerkiraanModelMap[key]!.id} \n"
                                  "Lat: ${dataPerkiraanModelMap[key]!.lat} \n"
                                  "Long: ${dataPerkiraanModelMap[key]!.lgt} \n"
                                  "Perkiraan Jarak Gangguan: ${dataPerkiraanModelMap[key]!.perkiraanJarakGangguan} m\n",
                              style:const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.white,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(dataPerkiraanModelMap[key]!.lat!.toDouble(), dataPerkiraanModelMap[key]!.lgt!.toDouble()),
            );
          },
        );
      } else {
        marker = Marker(
            markerId: MarkerId(
                key),
            position: LatLng(dataPerkiraanModelMap[key]!.lat!.toDouble(), dataPerkiraanModelMap[key]!.lgt!.toDouble()),
            icon: markerIcon,
            infoWindow: InfoWindow(
              title: "Id: ${dataPerkiraanModelMap[key]!.id} \n"
                  "Lat: ${dataPerkiraanModelMap[key]!.lat} \n"
                  "Long: ${dataPerkiraanModelMap[key]!.lgt} \n"
                  "Perkiraan Jarak Gangguan: ${dataPerkiraanModelMap[key]!.perkiraanJarakGangguan} m\n",
            )
        );
      }
      markers.add(marker);
      localMarker.add(marker);
    }
    GoogleMapsWidget.cameraToUser(LatLng(dataPerkiraanModelMap[dataPerkiraanModelMap.keys.last]!.lat!, dataPerkiraanModelMap[dataPerkiraanModelMap.keys.last]!.lgt!));
    return localMarker;
  }

  Future<Set<Marker>> addMarkersAndGetTrackingHistoryDetail(Map<String,TrackingHistoryDetailModel> datatrackingHistoryDetailModelMap,BitmapDescriptor markerIcon) async{
    var localMarker = <Marker>{};
    late Marker marker;
    for(var key in datatrackingHistoryDetailModelMap.keys){
      for(var item in datatrackingHistoryDetailModelMap[key]!.data!){
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
        marker = Marker(
          markerId: MarkerId(
              "THD-M${item.id.toString()}"),
          position: LatLng(item.lat!.toDouble(), item.lgt!.toDouble()),
          icon: markerIcon,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              // "Id: ${item.id} \n"
                              "UserId: ${item.userId} \n"
                                  "Lat: ${item.lat} \n"
                                  "Long: ${item.lgt} \n"
                                  "DateTime: ${item.dateTime} \n",
                              style:const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.white,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(item.lat!.toDouble(), item.lgt!.toDouble()),
            );
          },
        );
      } else {
        marker = Marker(
            markerId: MarkerId(
                "THD-M${item.id.toString()}"),
            position: LatLng(item.lat!.toDouble(), item.lgt!.toDouble()),
            icon: markerIcon,
            infoWindow: InfoWindow(
              title:
              // "Id: ${item.id} \n"
              "UserId: ${item.userId} \n"
                  "Lat: ${item.lat} \n"
                  "Long: ${item.lgt} \n"
                  "DateTime: ${item.dateTime}\n",
            )
        );
      }
      log("Tracking History Detail Logs: ${marker.markerId}");
      markers.add(marker);
      localMarker.add(marker);
      }
    }
    GoogleMapsWidget.cameraToUser(LatLng(datatrackingHistoryDetailModelMap[datatrackingHistoryDetailModelMap.keys.last]!.data!.last.lat!, datatrackingHistoryDetailModelMap[datatrackingHistoryDetailModelMap.keys.last]!.data!.last.lgt!));
    return localMarker;
  }

  Future<void> removePolylines(Polyline polyline) async{
    polylines.remove(polyline);
  }

  Future<void> removeMarkers(var markersParam) async{
    markers.removeAll(markersParam);
    // for(var item in currentMarkers1){
    //   markers.removeWhere(
    //           (element) => element.markerId.value == item.markerId.value);
    // }
  }

  // /* connected disconnected mechanism */
  // late var connectedUser = <String>{};
  // late var idleUser = <String>{};
  // Timer? timeout;
  //
  // void disconnectListMechanism(String userId){
  //     timeout = setTimeout(disconnectUser() ?? () => log("disconect() wasn't executed"));
  //     int indexDesired = connectedUser.length - 1;
  //     if (connectedUser.elementAt(indexDesired) != userId) {
  //       clearTimeout(timeout!);
  //       idleUser.add(connectedUser.elementAt(indexDesired));
  //       connectedUser.remove(connectedUser.elementAt(indexDesired));
  //       timeout = setTimeout(disconnectUser()!);
  //     }
  //   if (idleUser.contains(userId)) {
  //     idleUser.remove(userId);
  //     clearTimeout(timeout!);
  //   }
  // }
  //
  // VoidCallback? disconnectUser(){
  //   for(var item in idleUser){
  //     userIdConnectedSet.remove(item);
  //   }
  //   print("userId set now: ${userIdConnectedSet.length}");
  // }
  ////////////////dropdown///////////////
  /* dropdownItems instantiate*/
  late DropdownItemsProvider _dropdownItemsProvider;
  late DropdownItemsSecondProvider _dropdownItemsSecondProvider;
  var dropdownItems = DropdownItems().obs;
  var dropDownItemsSecond = DropdownItemsSecond().obs;
  var isLoadingDropdown = false.obs;
  var isErrorDropdown = false.obs;
  List<DropdownMenuItem<String>> menuItemsRemarks = <DropdownMenuItem<String>>[].obs;
  List<DropdownMenuItem<String>> menuItemTregs = <DropdownMenuItem<String>>[].obs;
  List<DropdownMenuItem<String>> menuItemWitels = <DropdownMenuItem<String>>[].obs;
  List<DropdownMenuItem<String>> menuItemRoutes = <DropdownMenuItem<String>>[].obs;
  List<String> headList = <String>[];

  // void getDropdownItems() async{
  //   try{
  //     isLoadingDropdown(true);
  //     isErrorDropdown(false);
  //     dropdownItems.value = (await _dropdownItemsProvider.getDropdownItems())!;
  //     dropdownItems.value.dropdownItemItems?.all?.forEach((item) {
  //       menuItems.add(DropdownMenuItem(child: Text(item),value:item));
  //     });
  //     dropdownItems.value.dropdownItemItems?.head?.forEach((item) {
  //       headList.add(item);
  //     });
  //     // log("dropdownItems: ${menuItems.last.value}");
  //   }catch(exception){
  //     log("API Exception: $exception");
  //     isErrorDropdown(true);
  //   }finally{
  //     isLoadingDropdown(false);
  //   }
  // }

  void getDropDownItemsTreg() async{
    try{
      isLoadingDropdown(true);
      isErrorDropdown(false);
      dropDownItemsSecond.value = (await _dropdownItemsSecondProvider.getDropdownItemsTreg())!;
      dropDownItemsSecond.value.dropdownItems?.forEach((item) {
        menuItemTregs.add(DropdownMenuItem(child: Text(item),value:item));
      });
      // log("dropdownItems: ${menuItems.last.value}");
    }catch(exception){
      log("API Exception: $exception");
      isErrorDropdown(true);
    }finally{
      isLoadingDropdown(false);
    }
  }

  void getDropDownItemsWitel(String treg) async{
    try{
      isLoadingDropdown(true);
      isErrorDropdown(false);
      if(witel.value != "") {
        witel.value = "";
      }
      if(menuItemWitels.isNotEmpty){
        menuItemWitels.clear();
      }
      dropDownItemsSecond.value = (await _dropdownItemsSecondProvider.getDropdownItemsWitel(treg))!;
      dropDownItemsSecond.value.dropdownItems?.forEach((item) {
        menuItemWitels.add(DropdownMenuItem(child: Text(item),value:item));
      });
      // log("dropdownItems: ${menuItems.last.value}");
    }catch(exception){
      log("API Exception: $exception");
      isErrorDropdown(true);
    }finally{
      isLoadingDropdown(false);
    }
  }

  void getDropdownItemsRemark(String treg, String witel) async{
    try{
      isLoadingDropdown(true);
      isErrorDropdown(false);
      if(remarkFrom.value != "") {
        remarkFrom.value = "";
      }
      if(remarkTo.value != "") {
        remarkTo.value = "";
      }
      if(menuItemsRemarks.isNotEmpty){
        menuItemsRemarks.clear();
      }
      dropdownItems.value = (await _dropdownItemsProvider.getDropdownItemsRemarks(treg, witel))!;
      dropdownItems.value.dropdownItemItems?.all?.forEach((item) {
        menuItemsRemarks.add(DropdownMenuItem(child: Text(item),value:item));
      });
      dropdownItems.value.dropdownItemItems?.head?.forEach((item) {
        headList.add(item);
      });
      // log("dropdownItems: ${menuItems.last.value}");
    }catch(exception){
      log("API Exception: $exception");
      isErrorDropdown(true);
    }finally{
      isLoadingDropdown(false);
    }
  }

  void getDropDownItemsRoutes(String tregParam,String witelParam,String remarkParam) async{
    try{
      isLoadingDropdown(true);
      isErrorDropdown(false);
      if(menuItemRoutes.isNotEmpty){
        menuItemRoutes.clear();
      }
      dropDownItemsSecond.value = (await _dropdownItemsSecondProvider.getDropdownItemsRoute(tregParam,witelParam,remarkParam))!;
      dropDownItemsSecond.value.dropdownItems?.forEach((item) {
        menuItemRoutes.add(DropdownMenuItem(child: Text(item),value:item));
      });
      // log("dropdownItems: ${menuItems.last.value}");
    }catch(exception){
      log("API Exception: $exception");
      isErrorDropdown(true);
    }finally{
      isLoadingDropdown(false);
    }
  }

  @override
  void onInit() {
    // mustLoginMechanism();
    tabController = TabController(vsync: this, length: 2);
    scrollController = ScrollController();
    panelController = PanelController();
    _dropdownItemsProvider = DropdownItemsProvider();
    _dropdownItemsProvider.onInit();
    _dropdownItemsSecondProvider = DropdownItemsSecondProvider();
    _dropdownItemsSecondProvider.onInit();
    _dropdownItemsProvider.onInit();
    _alproModelProvider = AlproModelProvider();
    _alproModelProvider.onInit();
    _dataPerkiraanResponseProvider = LocationDataPerkiraanResponseProvider();
    _dataPerkiraanResponseProvider.onInit();
    _dataGangguanResponseProvider = LocationDataGangguanResponseProvider();
    _dataGangguanResponseProvider.onInit();
    _trackingHistoryModelProvider = TrackingHistoryModelProvider();
    _trackingHistoryModelProvider.onInit();
    _trackingHistoryDetailModelProvider = TrackingHistoryDetailModelProvider();
    _trackingHistoryDetailModelProvider.onInit();
    getBytesFromAsset("assets/images/ic_people_marker.png", 128).then((value) {
      bitmapImage = BitmapDescriptor.fromBytes(value);
    });
    super.onInit();
  }

  @override
  void onReady() {
    // getTrackingHistoryData(userId: "Andi123", dateStart: "2020-08-14", dateEnd: "2022-08-16");
    // getTrackingHistoryDetailData(token: "daf0cf6f-7742-4c98-88a4-0dee68a6c5ea");

    // getDropdownItems();
    getDropDownItemsTreg();
    getBytesFromAsset("assets/images/ic_azure_marker.png", 42).then((value) {
      bitmapImage2 = BitmapDescriptor.fromBytes(value);
    });
    getBytesFromAsset("assets/images/ic_point_marker.png", 42).then((value) {
      bitmapImage3 = BitmapDescriptor.fromBytes(value);
    });

    getBytesFromAsset("assets/images/ic_yellow_marker2.png", 42).then((value) {
      bitmapImage4 = BitmapDescriptor.fromBytes(value);
    });

    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
  // void increment() => count.value++;

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void mustLoginMechanism() async{
    try{
      final valueUserId = await getStringFromSharedPreferences("userId");
      final valueCProfile =  await getStringFromSharedPreferences("c_profile");
      if(valueUserId.isNotEmpty && valueCProfile.isNotEmpty){
        log("Shared Preference : $valueUserId and $valueCProfile");
        loginUserId(valueUserId);
        cProfile(valueCProfile);
      }else{
        log("Error Shared Preference");
        Get.offAllNamed('/login');
      }

      /////////////////old mechanism////////////////
     //  getStringFromSharedPreferences("userId").then((value) {
     //    loginUserId(value);
     //    log("Shared Preference loginUserId: $value");
     //  },onError: (e){
     //    log("Error Shared Preference loginUserId: $e");
     //    Get.offAllNamed('/login');
     //  });
     // getStringFromSharedPreferences("c_profile").then((value) {
     //    cProfile(value);
     //    log("Shared Preference cProfile: $value");
     //  },onError: (e){
     //   log("Error Shared Preference cProfile: $e");
     //   Get.offAllNamed('/login');
     // });
     // loginUserId(await getStringFromSharedPreferences("userId"));
    }catch(exception){
      Get.back();
    }
  }

  Future<String> getStringFromSharedPreferences(String key) async{
    late final String itemStr;
    await SharedPreferences.getInstance().then((value) {
      itemStr = value.getString(key)!;
    });

    return itemStr;
  }

  Future<bool> removeSharedPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('userId');
    await prefs.remove('c_profile');
    return success;
  }
  // Timer setTimeout(VoidCallback callback, [int duration = 10]) {
  //   return Timer(Duration(seconds: duration), callback);
  // }
  //
  // void clearTimeout(Timer t) {
  //   t.cancel();
  // }
}
