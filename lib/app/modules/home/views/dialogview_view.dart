import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';

class DialogviewView {

  static void dialogViewAlpro(context,controller){
    controller.treg.value = "";
    controller.witel.value = "";
    Get.defaultDialog(
        title: "Other Alpro Parameters",
        titleStyle: TextStyle(fontSize: 25),
        content: Column(
          children: [
            DropdownButtonFormField(
              onChanged: (text) {
                controller.treg.value = text.toString();
                // log("Test OnChanged Dropdown: ${text.toString()}");
              },
              style: Theme.of(context).textTheme.headline6,
              decoration: const InputDecoration(
                  labelText: "Treg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              items: controller.menuItemTregs,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: DropdownButtonFormField(
                onChanged: (text) {
                  controller.witel.value = text.toString();
                  // log("Test OnChanged Dropdown: ${text.toString()}");
                },
                style: Theme.of(context).textTheme.headline6,
                decoration: const InputDecoration(
                    labelText: "Witel",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                items: controller.menuItemWitels,
              ),
            ),
          ],
        ),
        textCancel: "Cancel",
        textConfirm: "Search",
        buttonColor: Colors.red,
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.black,
        onConfirm: () {
          if (controller.currentMarkersAlpro.isNotEmpty) {
            controller.removeMarkers(controller.currentMarkersAlpro);
            controller.removePolylines(controller.currentPolylineAlpro);
          }

          controller.getAlpro(controller.remark_2.value,controller.treg.value,controller.witel.value);
          if(controller.treg.value != "" && controller.witel.value != ""){
            Get.back();
          }
        }
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('DialogviewView'),
  //       centerTitle: true,
  //     ),
  //     body: Center(
  //       child: Text(
  //         'DialogviewView is working',
  //         style: TextStyle(fontSize: 20),
  //       ),
  //     ),
  //   );
  // }
}
