import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/user_model.dart';
import '../data/services/user_service.dart';
import '../routes/app_route.dart';

class ProfileController extends GetxController {
  var isImagePicked = false.obs;
  var profileImage = ''.obs;
  var user = Rxn<UsersModel>();

  @override
  void onInit() {
    super.onInit();
    // fetchCurrentUser();
  }

  // void fetchCurrentUser() async {
  //   UsersModel? data = await UserService.getCurrentUser();
  //   if (data != null) {
  //     user.value = data;
  //   }
  // }

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

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
      isImagePicked.value = true;
    }
  }
}
