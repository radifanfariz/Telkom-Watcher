import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trackernity_watcher/other/CustomScrollBehavior.dart';
import 'app/data/socket/socket_initiate.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
  connectAndListen();
}
