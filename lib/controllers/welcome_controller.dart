import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/AppStyles.dart';
import '../../routes/app_route.dart';
import '../services/api_service.dart';

class SignInController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> saveLoginStatus(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', username); // simpan username
  }

  Future<String?> getSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
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
        // Mengambil instance sharedPreferences
        final sharedPreferences = await SharedPreferences.getInstance();
        // await saveLoginStatus();

        // Mengecek role setelah login
        if (response['user']['role'] != 'student') {
          Get.snackbar(
            'Akses Ditolak',
            'Akun ini bukan siswa. Silakan login di aplikasi yang sesuai.',
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white,
          );

          await sharedPreferences.remove('token');
          await sharedPreferences.remove('username');

          Get.offAllNamed(Routes.splash);
          return;
        }

        Get.snackbar(
          'Login Berhasil',
          'Selamat datang, ${response['user']['name']}!',
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
