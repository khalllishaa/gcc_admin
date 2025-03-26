import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/AppStyles.dart';
import '../../routes/app_route.dart';

class SignInController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  void goToSignIn() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Login Gagal',
        'Username dan password tidak boleh kosong!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
      );
      return;
    }

    if (username == 'admin' && password == '1234') {
      await saveLoginStatus(); // Simpan status login setelah sukses

      Get.snackbar(
        'Login Berhasil',
        'Selamat datang, $username!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.secondaryLight,
        colorText: AppStyles.dark,
      );

      Future.delayed(Duration(seconds: 1), () {
        Get.offNamed(Routes.welcome);
      });
    } else {
      Get.snackbar(
        'Login Gagal',
        'Username atau password salah!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
      );
    }
  }

  void goToSignUp() {
    Get.toNamed(Routes.signup);
  }

}