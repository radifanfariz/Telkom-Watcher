import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/tabview1.dart';
import 'package:trackernity_watcher/app/modules/home/views/components/tabview2.dart';
import 'package:trackernity_watcher/app/modules/home/views/helpers/responsiveness.dart';
import 'package:trackernity_watcher/app/modules/home/views/widgets/largescreen_widget.dart';
import 'package:trackernity_watcher/app/modules/home/views/widgets/smallscreen_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.mustLoginMechanism();
    return Scaffold(
        body: ResponsiveWidget(largeScreen: LargeScreenWidget(),smallScreen: SmallScreenWidget(),mediumScreen: LargeScreenWidget(),)
    );
  }
}
