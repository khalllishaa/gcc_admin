import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/AppStyles.dart';
import '../../routes/app_route.dart';

class SignInController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> saveLoginStatus(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', username);
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

      final response = await http.post(
        Uri.parse('https://c0ae-160-22-25-26.ngrok-free.app/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': username, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['message'] == 'Login successful') {
        final user = data['user'];

        if (user['role'] != 'admin') {
          Get.snackbar(
            'Akses Ditolak',
            'Akun ini bukan siswa. Silakan login di aplikasi yang sesuai.',
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white,
          );

          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();

          Get.offAllNamed(Routes.splash);
          return;
        }

        await saveLoginStatus(user['name']);

        Get.snackbar(
          'Login Berhasil',
          'Selamat datang, ${user['name']}!',
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
