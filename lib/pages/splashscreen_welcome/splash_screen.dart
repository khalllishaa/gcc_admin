import 'package:flutter/material.dart';
import 'package:gcc_admin/controllers/splashscreen_controller.dart';
import 'package:get/get.dart';

import '../../components/AppStyles.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  SplashscreenContoller contoller = Get.find();
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
            Text('Golden Children Club', style: AppStyles.splashscreen),
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
