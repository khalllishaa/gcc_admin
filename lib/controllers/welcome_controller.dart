import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/AppStyles.dart';
import '../../routes/app_route.dart';
import '../services/api_service.dart'; // tambahkan import ini

class SignInController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;

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

    try {
      isLoading.value = true;

      final response = await ApiService.login(username, password);

      if (response['message'] == 'Login successful') {
        await saveLoginStatus();

        Get.snackbar(
          'Login Berhasil',
          'Selamat datang, ${response['user']['name']}!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppStyles.secondaryLight,
          colorText: AppStyles.dark,
        );

        Future.delayed(Duration(seconds: 1), () {
          Get.offNamed(Routes.main);
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
    } catch (e) {
      Get.snackbar(
        'Login Gagal',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignUp() {
    Get.toNamed(Routes.signup);
  }
}
