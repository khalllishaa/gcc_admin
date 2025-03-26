import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/AppStyles.dart';
import '../../routes/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo_gcc.png',
              width: AppStyles.logo,
            ),
            SizedBox(height: AppStyles.spaceL),
            Text('Golden Children Club', style: AppStyles.headingStyle),
            SizedBox(height: AppStyles.spaceL),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppStyles.light),
            )
          ],
        ),
      ),
    );
  }
}