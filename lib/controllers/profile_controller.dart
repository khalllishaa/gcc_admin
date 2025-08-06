import 'dart:convert';
import 'dart:io';

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
    fetchCurrentUser();
  }

  // void fetchCurrentUser() async {
  //   UsersModel? data = await UserService.getCurrentUser();
  //   if (data != null) {
  //     user.value = data;
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setString('userData', json.encode(data.toJson()));
  //   }
  // }

  Future<void> fetchCurrentUser([int? id]) async {
    UsersModel? data = await UserService.getCurrentUser();
    if (data != null) {
      user.value = data;

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', json.encode(data.toJson()));
    }
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

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
      isImagePicked.value = true;

      await uploadPickedImage();
    }
  }

  Future<void> uploadPickedImage() async {
    if (user.value == null || profileImage.value.isEmpty) return;

    final userId = user.value!.id;
    final imageFile = File(profileImage.value);

    // Get.snackbar(
    //   'Uploading',
    //   'Mengunggah foto profil...',
    //   backgroundColor: AppStyles.secondaryLight,
    //   snackPosition: SnackPosition.BOTTOM,
    //   margin: EdgeInsets.all(12),
    // );

    try {
      bool success = await UserService.uploadProfilePicture(userId, imageFile);

      if (success) {
        // Get.snackbar(
        //   'Berhasil',
        //   'Foto profil berhasil diunggah!',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   snackPosition: SnackPosition.BOTTOM,
        // );

        fetchCurrentUser(userId); // Refresh data user setelah upload
      } else {
        throw Exception('Gagal upload');
      }
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Upload gagal: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
