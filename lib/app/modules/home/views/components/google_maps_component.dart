import 'dart:async';
import 'dart:developer';

import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trackernity_watcher/app/data/models/location_data_realtime_model.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/socket_component.dart';

class GoogleMapsWidget extends GetView<HomeController>{

  GoogleMapsWidget._internal();
  
  static final GoogleMapsWidget _googleMapsWidget = GoogleMapsWidget._internal();
  
  factory GoogleMapsWidget(){
    return _googleMapsWidget;
  }

  // final Completer<GoogleMapController> _controller = Completer();

  static late GoogleMapController googleMapController;

  // final _latLngList = <LatLng>[];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
        return BuildWithSocketStream(
          builder: (context,snapshot) {
            if (snapshot.data != null) {
              controller.locationDataRealtime.value = snapshot.data!;
              var cProfile = snapshot.data?.cProfile;
              log("Test c_profile on GoogleMaps: ${controller.cProfile.value}");
              if(cProfile == controller.cProfile.value) {
                updateMapComponents(snapshot.data!);
              }
              // print("test location data realtime: ${controller.locationDataRealtime.value.userId}");
            }
            return Obx(
              () {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: controller.markers,
                  circles: controller.circles,
                  polylines: controller.polylines,
                  onMapCreated: (GoogleMapController gMapsController) {
                    googleMapController = gMapsController;
                    controller.customInfoWindowController.googleMapController = gMapsController;
                  },
                  onTap: (position) {
                    controller.customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    controller.customInfoWindowController.onCameraMove!();
                  },
                );
              }
            );
          }
        );
  }

  void updateMapComponents(
      LocationDataRealtime locationDataRealtime) async {
    controller.latLng.value = LatLng(locationDataRealtime.lat!.toDouble(),
        locationDataRealtime.lgt!.toDouble());
    controller.markers.removeWhere(
        (element) => element.markerId.value == locationDataRealtime.userId);
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
      controller.markers.add(Marker(
          markerId: MarkerId(locationDataRealtime.userId!),
          position: controller.latLng.value,
          // rotation: newLocalData['heading'].toDouble(),
          draggable: false,
          zIndex: 2,
          visible: controller.isShowMarkerAndPolylines.value,
          onTap: () {
            controller.customInfoWindowController.addInfoWindow!(
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
                              "${locationDataRealtime.nama}\n"
                                  "${locationDataRealtime.userId} \n",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      width: 150.0,
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
              LatLng(locationDataRealtime.lat!.toDouble(),
                  locationDataRealtime.lgt!.toDouble()),
            );
          },
          // flat: true,
          // anchor: const Offset(0.5, 0.5),
          // infoWindow: InfoWindow(
          //   title: "${locationDataRealtime.nama} \n ${locationDataRealtime.userId}",
          // ),
          icon: controller.bitmapImage));
    }else{
      controller.markers.add(Marker(
          markerId: MarkerId(locationDataRealtime.userId!),
          position: controller.latLng.value,
          // rotation: newLocalData['heading'].toDouble(),
          draggable: false,
          zIndex: 2,
          visible: controller.isShowMarkerAndPolylines.value,
          // flat: true,
          // anchor: const Offset(0.5, 0.5),
          infoWindow: InfoWindow(
            title: "${locationDataRealtime.nama} \n"
                "${locationDataRealtime.userId}",
          ),
          icon: controller.bitmapImage));
    }
    controller.circles.add(Circle(
        circleId: CircleId(locationDataRealtime.userId!),
        // radius: newLocalData['accuracy'].toDouble(),
        zIndex: 1,
        strokeColor: Colors.blue,
        center: controller.latLng.value,
        fillColor: Colors.blue.withAlpha(70)));

    if(controller.isAddPolylinesActive.value) {
      controller.latLngListPolylines.add(controller.latLng.value);
      // print("test latLng List: ${_latLngList}");
      // print("test isPolylinesShow: ${controller.isPolylinesShow.value}");
      controller.polylines.add(Polyline(
          polylineId: PolylineId(locationDataRealtime.userId!),
          visible: controller.isShowMarkerAndPolylines.value,
          points: controller.latLngListPolylines,
          color: Colors.black,
          geodesic: true
      ));
    }

    // if(locationDataRealtime.userId == controller.userId.value) {
    //   _googleMapController.animateCamera(
    //       CameraUpdate.newLatLngZoom(controller.latLng.value, 15));
    // }
    // print("test markers: ${controller.markers.length}");
    // print("test polylines: ${controller.polylines.length}");
    // print("test _latLngList: ${controller.latLngListPolylines.length}");
  }

  static void cameraToUser(LatLng latLng) {
    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
    // _googleMapController.dispose();
  }
}