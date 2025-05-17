import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/AppStyles.dart';
import '../../routes/app_route.dart';
import '../data/models/auth_model.dart';
import '../data/services/auth_service.dart';

class SignInController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> saveLoginData(AuthModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', user.name);
    await prefs.setString('token', user.token);
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

      final response = await AuthService.login(username, password);
      if (response['message'] == 'Login successful') {
        AuthModel user = response['user'];

        if (user.role != 'admin') {
          Get.snackbar(
            'Akses Ditolak',
            'Akun ini bukan siswa. Silakan login di aplikasi yang sesuai.',
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white,
          );

          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          await prefs.remove('username');

          Get.offAllNamed(Routes.splash);
          return;
        }

        await saveLoginData(user);

        Get.snackbar(
          'Login Berhasil',
          'Selamat datang, ${user.name}!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppStyles.secondaryLight,
          colorText: AppStyles.dark,
        );

        Future.delayed(const Duration(seconds: 1), () {
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
