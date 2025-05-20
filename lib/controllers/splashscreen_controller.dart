import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_route.dart';


class SplashscreenContoller extends GetxController {

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        Get.offAllNamed(Routes.main);
      } else {
        Get.offAllNamed(Routes.signin);
      }
    });
  }
}