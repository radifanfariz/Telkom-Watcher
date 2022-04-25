import 'package:get/get.dart';
import 'package:trackernity_watcher/app/modules/auth/bindings/auth_binding.dart';
import 'package:trackernity_watcher/app/modules/auth/views/login_view.dart';
import 'package:trackernity_watcher/app/modules/auth/views/signup_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
      binding: AuthBinding(),
    ),
  ];
}
