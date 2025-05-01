import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_route.dart';

class ProfileController extends GetxController{

  // Observable for image picked state
  var isImagePicked = false.obs;
  var profileImage = ''.obs;

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
      titleStyle: AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
      middleTextStyle: AppStyles.welcome2,
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
          style: AppStyles.welcome2,
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
          style: AppStyles.welcome2,
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
      isImagePicked.value = true;
    }
  }
}