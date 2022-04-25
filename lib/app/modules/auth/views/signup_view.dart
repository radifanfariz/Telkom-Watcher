import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackernity_watcher/app/modules/auth/controllers/auth_controller.dart';

import '../../../constants.dart';

class SignUpView extends GetView<AuthController> {

  SignUpView({Key? key}) : super(key: key);

  final _passwordVisible = false.obs;
  final _repeatpasswordVisible = false.obs;

  // List<DropdownMenuItem<String>> get dropdownItems{
  //   List<DropdownMenuItem<String>> menuItems = [
  //     const DropdownMenuItem(child: Text("USA"),value:"USA"),
  //     const DropdownMenuItem(child: Text("Canada"),value:"Canada"),
  //     const DropdownMenuItem(child: Text("Brazil"),value:"Brazil"),
  //     const DropdownMenuItem(child: Text("England"),value:"England"),
  //   ];
  //   return menuItems;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                    color: Colors.red,
                    image: DecorationImage(
                      image: AssetImage("assets/images/doodad.png"),
                      fit: BoxFit.none,
                    )
                )
            ),
            Obx(
                    () {
                  return Visibility(
                      visible: controller.isLoadingDropdownAuth.value,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                  );
                }
            ),
            Center(
              child: Obx(
                () {
                  if(controller.dropdownItemsAuth.isNotEmpty) {
                    return Visibility(
                      visible: !controller.isLoadingDropdownAuth.value,
                      child: PhysicalModel(
                      color: Colors.black,
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Scrollbar(
                        child: Container(
                          height: 500,
                          width: 350,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color:Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 50),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontFamily: "Dongle",
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Nama",
                                            style: TextStyle(
                                                fontFamily: "Dongle",
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        TextField(
                                          onChanged: (text){
                                            controller.nama(text);
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              hintText: "Nama",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "User ID",
                                            style: TextStyle(
                                                fontFamily: "Dongle",
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        TextField(
                                          onChanged: (text){
                                            controller.userid(text);
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              hintText: "User id",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Password",
                                            style: TextStyle(
                                                fontFamily: "Dongle",
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Obx(
                                                () {
                                              return TextField(
                                                onChanged: (text){
                                                  controller.password(text);
                                                },
                                                keyboardType: TextInputType.text,
                                                obscureText: !_passwordVisible.value,
                                                decoration: InputDecoration(
                                                    hintText: "Password",
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          _passwordVisible.value ? Icons.visibility : Icons.visibility_off
                                                      ),
                                                      color: Colors.black,
                                                      onPressed: () {
                                                        _passwordVisible(!_passwordVisible.value);
                                                      },
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                    )
                                                ),
                                              );
                                            }
                                        ),Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Repeat Password",
                                            style: TextStyle(
                                                fontFamily: "Dongle",
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Obx(
                                                () {
                                              return TextField(
                                                onChanged: (text){
                                                  controller.repeatPassword(text);
                                                },
                                                keyboardType: TextInputType.text,
                                                obscureText: !_repeatpasswordVisible.value,
                                                decoration: InputDecoration(
                                                    hintText: "Repeat Password",
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          _repeatpasswordVisible.value ? Icons.visibility : Icons.visibility_off
                                                      ),
                                                      color: Colors.black,
                                                      onPressed: () {
                                                        _repeatpasswordVisible(!_repeatpasswordVisible.value);
                                                      },
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                    )
                                                ),
                                              );
                                            }
                                        ),
                                        ////////////////////////////dropdown from here//////////////////////////////////////
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Regional",
                                            style: TextStyle(
                                                fontFamily: "Dongle",
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          onChanged: (text){
                                            controller.regional(text.toString());
                                            final index = controller.menuItemsRegional.indexOf(text.toString());
                                            controller.codeMap["Regional"] = controller.codeList.elementAt(index);
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Regional",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              )
                                          ), items: controller.menuItemsRegional.map((value) {
                                            return DropdownMenuItem(
                                                child: Text(value),
                                                value: value);
                                        }).toList(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Witel",
                                            style: TextStyle(
                                                fontFamily: "Dongle",
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          onChanged: (text){
                                            controller.witel(text.toString());
                                            final index = controller.menuItemsWitel.indexOf(text.toString());
                                            controller.codeMap["Witel"] = controller.codeList.elementAt(index);
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Witel",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              )
                                          ), items: controller.menuItemsWitel.map((value) {
                                          return DropdownMenuItem(
                                              child: Text(value),
                                              value: value);
                                        }).toList(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Unit",
                                            style: TextStyle(
                                                fontFamily: "Dongle",
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          onChanged: (text){
                                            controller.unit(text.toString());
                                            final index = controller.menuItemsUnit.indexOf(text.toString());
                                            controller.codeMap["Unit"] = controller.codeList.elementAt(index);
                                            // log("Unit Value: ${controller.menuItemsUnit.last}");
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Unit",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              )
                                          ), items: controller.menuItemsUnit.map((value) {
                                          return DropdownMenuItem(
                                              child: Text(value),
                                              value: value);
                                        }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ///////////////////////////Submit Button////////////////////
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    height: 65,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.black),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ))
                                      ),
                                      onPressed: () {
                                        constructCProfileParam();
                                        controller.signUp().then((value){
                                          ConstantClass.showToast(value!);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 30.0),
                                            child: Text("Sign Up"),
                                          ),
                                          Obx(
                                                  () {
                                                return Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: Visibility(
                                                        visible: controller.isLoading.value,
                                                        child: const CircularProgressIndicator(
                                                          color: Colors.red,
                                                        )
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                    );
                  } else{
                    return Visibility(
                      visible: !controller.isLoadingDropdownAuth.value,
                      child: PhysicalModel(
                        color: Colors.black,
                        elevation: 8.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Container(
                          height: 500,
                          width: 350,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color:Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Flexible(child: Text("Something went wrong !!!",style: TextStyle(color: Colors.red),)),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(onPressed: () {
                                controller.getDropdownItemsAuth();
                              }, child: const Text("Refresh"))
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
              ),
            ),
            Positioned(
                bottom: 50,
                child: Text.rich(
                    TextSpan(
                        text: "Already have an account ? ",
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () => {
                                Get.offAllNamed('/login')
                              },
                              text: "Login here",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )
                          )
                        ]
                    )
                )
            ),
          ],
        )
    );
  }

  void constructCProfileParam(){
      final codeRegional = controller.codeMap["Regional"];
      final codeWitel = controller.codeMap["Witel"];
      final codeUnit = controller.codeMap["Unit"];
      controller.cProfile.value = "p-$codeRegional$codeWitel$codeUnit";
      log("cProfile Value: ${controller.cProfile.value}");
  }
}