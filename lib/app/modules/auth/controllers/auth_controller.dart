import 'dart:developer';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackernity_watcher/app/data/models/dropdown_items_auth_model.dart';
import 'package:trackernity_watcher/app/data/models/login_post_params_model.dart';
import 'package:trackernity_watcher/app/data/models/signup_post_params_model.dart';
import 'package:trackernity_watcher/app/data/providers/dropdown_items_auth_provider.dart';
import 'package:trackernity_watcher/app/data/providers/login_provider.dart';
import 'package:trackernity_watcher/app/data/providers/signup_provider.dart';

import '../../../data/models/login_model.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  ////Login/SignUp Field////
  final userid = "".obs;
  final password = "".obs;
  final repeatPassword = "".obs;
  final regional = "".obs;
  final witel = "".obs;
  final unit = "".obs;
  final cProfile = "".obs;
  final nama = "".obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    _dropdownItemsAuthProvider = DropdownItemsAuthProvider();
    _dropdownItemsAuthProvider.onInit();
    super.onInit();
  }

  @override
  void onReady() {
    getDropdownItemsAuth();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ////////////////dropdown auth///////////////
  /* dropdownItemsAuth instantiate*/
  late DropdownItemsAuthProvider _dropdownItemsAuthProvider;
  var dropdownItemsAuth = <DropdownItemsAuth?>[].obs;
  var isLoadingDropdownAuth = false.obs;
  var isErrorDropdownAuth = false.obs;
  final Map<String,String> codeMap = {
    "Regional":"",
    "Witel":"",
    "Unit":"",
  };
  List<String> codeList = <String>[].obs;
  List<String> menuItemsRegional = <String>[].obs;
  List<String> menuItemsWitel = <String>[].obs;
  List<String> menuItemsUnit = <String>[].obs;

  void getDropdownItemsAuth() async{
    try{
      isLoadingDropdownAuth(true);
      isErrorDropdownAuth(false);
      dropdownItemsAuth.value = await _dropdownItemsAuthProvider.getDropdownItemsAuth();
      dropdownItemsAuth.value.forEach((item) {
        if (item != null) {
          codeList.add(item.code.toString());
          if (item.regional != null) {
            menuItemsRegional.add(item.regional.toString());
          }
          if (item.witel != null) {
            menuItemsWitel.add(item.witel.toString());
          }
          if (item.unit != null) {
            menuItemsUnit.add(item.unit.toString());
          }
        }
      });
      // log("dropdownItemsAuth: ${menuItemsWitel.last.child}");
    }catch(exception){
      log("API Exception: $exception");
      isErrorDropdownAuth(true);
    }finally{
      isLoadingDropdownAuth(false);
    }
  }

  Future<String?> login() async{
    isLoading(true);
    LoginProvider loginProvider = LoginProvider();
    loginProvider.onInit();
    final LoginPostParams loginPostParams = LoginPostParams(
      userId: userid.value,
      pass: encryptPassword(password.value),
    );
    return await loginProvider.postLogin(loginPostParams).then((value) {
      if(!value.status.connectionError) {
        if (value.statusCode == 200) {
          Login login = value.body;
          final userIdResponse = login.data?.last.user?.userid;
          final cProfileResponse = login.data?.last.user?.cProfile;
          if(userIdResponse != null && cProfileResponse != null){
            setStringToSharedPreferences(userIdResponse);
            setStringToSharedPreferencesCProfile(cProfileResponse);
            log("Shared Preference Auth : $userIdResponse and $cProfileResponse");
          }
          Get.offAllNamed('/home');
          return value.body.status;
        } else {
          return value.bodyString;
        }
      }else{
        return "No Connection !";
      }
    },onError: (e){
      return e.toString();
    }).catchError((e){
      return e.toString();
    }).whenComplete(() {
      isLoading(false);
      loginProvider.dispose();
    });
    // try{
    //   loginProvider.postLogin(loginPostParams).then((value) {
    //     Get.offAllNamed('/home');
    //     return value.body!.status;
    //   });
    // }catch(exception){
    //   return exception.toString();
    // }
  }

  Future<String?> signUp() async{
    isLoading(true);
    SignupProvider signupProvider = SignupProvider();
    signupProvider.onInit();
    final SignupPostParams signupPostParams = SignupPostParams(
      userId: userid.value,
      pass: password.value,
      passRepeat: repeatPassword.value,
      regional: regional.value,
      witel: witel.value,
      unit: unit.value,
      cProfile: cProfile.value,
      nama: nama.value,
    );
    return await signupProvider.postSignup(signupPostParams).then((value) {
      if(!value.status.connectionError) {
        if (value.statusCode == 200) {
          Get.offAllNamed('/login');
          return value.body.status;
        } else {
          return value.bodyString;
        }
      }else{
        return "No Connection !";
      }
    },onError: (e){
      return e.toString();
    }).catchError((e){
      return e.toString();
    }).whenComplete(() {
      isLoading(false);
      signupProvider.dispose();
    });
    // try{
    //   await signupProvider.postSignup(signupPostParams).then((value) {
    //     Get.offAllNamed('/login');
    //     return value.body!.status;
    //   });
    // }catch(exception){
    //   return exception.toString();
    // }
  }

  Map<String,dynamic> encryptPassword(String pass){
    final key = encrypt.Key.fromUtf8('A88BF378612E335FB3B35DD6D57EC000');
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key,mode: encrypt.AESMode.cbc));

    final encrypted = encrypter.encrypt(pass, iv: iv);
    final encryptedPass  = <String,dynamic>{
      "iv": iv.base16,
      "encryptedData":encrypted.base16,
    };
    log("Test Data Encrypted: ${encryptedPass["iv"]} and ${encryptedPass["encryptedData"]}");
    return encryptedPass;
  }

  void setStringToSharedPreferences(String str) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", str);
  }

  void setStringToSharedPreferencesCProfile(String str) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("c_profile", str);
  }
}
