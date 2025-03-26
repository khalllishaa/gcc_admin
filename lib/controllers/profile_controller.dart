import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_route.dart';

class ProfileController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    Get.defaultDialog(
      title: "Log Out",
      middleText: "Are you sure you want to log out?",
      titleStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppStyles.light,
      ),
      middleTextStyle: TextStyle(
        fontSize: 16,
        color: AppStyles.light,
      ),
      backgroundColor: AppStyles.primary,
      radius: AppStyles.radiusXL,
      barrierDismissible: false,
      cancel: OutlinedButton(
        onPressed: () {
          Get.back();
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppStyles.light),
        ),
        child: Text(
          "No",
          style: TextStyle(fontSize: 16, color: AppStyles.light),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          await sharedPreferences.remove('isLoggedIn');
          Get.offAllNamed(Routes.signin);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyles.primaryLight,
          foregroundColor: AppStyles.light,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusXL),
          ),
        ),
        child: Text(
          "Yes",
          style: TextStyle(fontSize: 16, color: AppStyles.light),
        ),
      ),
    );
  }
}