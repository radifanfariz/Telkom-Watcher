import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/sheet_component.dart';

import 'tabview1.dart';
import 'tabview2.dart';

class SlidingUpPanelWidget extends GetView<HomeController>{

  SlidingUpPanelWidget._internal();

  static final SlidingUpPanelWidget _slidingUpPanelWidget = SlidingUpPanelWidget._internal();

  factory SlidingUpPanelWidget(){
    return _slidingUpPanelWidget;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SlidingUpPanel(
        controller: controller.panelController,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        maxHeight: MediaQuery.of(context).size.height,
        panel:SheetComponent(),
        onPanelOpened:(){
          controller.customInfoWindowController.hideInfoWindow!();
        },
    );
  }

}