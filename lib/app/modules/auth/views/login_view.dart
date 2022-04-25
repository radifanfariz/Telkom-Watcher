import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trackernity_watcher/app/constants.dart';
import 'package:trackernity_watcher/app/modules/auth/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  LoginView({Key? key}) : super(key: key);

  final _passwordVisible = false.obs;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm");
  late var endDate = DateTime(2022,7,20,7,5);

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
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.red,
                    image: DecorationImage(
                      image: AssetImage("assets/images/doodad.png"),
                      fit: BoxFit.none,
                    ))),
            Center(
              child: PhysicalModel(
                color: Colors.black,
                elevation: 8.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Container(
                  height: 400,
                  width: 350,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "Login",
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
                                  "User ID",
                                  style: TextStyle(
                                      fontFamily: "Dongle",
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                onChanged: (text) {
                                  controller.userid(text);
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: "user id",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                      fontFamily: "Dongle",
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Obx(() {
                                return TextField(
                                  onChanged: (text) {
                                    controller.password(text);
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: !_passwordVisible.value,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                        icon: Icon(_passwordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        color: Colors.black,
                                        onPressed: () {
                                          _passwordVisible(
                                              !_passwordVisible.value);
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          height: 65,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))),
                            onPressed: () {
                              late var now = DateTime.now();
                              if(now.isAfter(endDate)) {
                                ConstantClass.showToast(
                                    "App has expired...!!!");
                              }else{
                                ConstantClass.showToast(
                                    "App is valid until $endDate");
                                (controller.userid.value.length > 6 &&
                                    controller.password.value.length > 6)
                                    ? controller.login().then((value) {
                                  ConstantClass.showToast(value!);
                                })
                                    : ConstantClass.showToast(
                                    "User Id and Password must be at least 6  characters !");
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text("Login"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Obx(() {
                                    return SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Visibility(
                                          visible: controller.isLoading.value,
                                          child:
                                          const CircularProgressIndicator(
                                            color: Colors.red,
                                          )),
                                    );
                                  }),
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
            Positioned(
                bottom: 100,
                child: Text.rich(
                    TextSpan(text: "Do you have an account ? ", children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {Get.toNamed('/signup')},
                          text: "Sign Up",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ))
                    ]))),
          ],
        ));
  }
}
