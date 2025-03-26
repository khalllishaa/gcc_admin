import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // SignUpController controller = Get.find();
    return Scaffold(
      backgroundColor: AppStyles.primaryLight,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppStyles.light,
                  borderRadius: BorderRadius.circular(AppStyles.radius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Daftar',
                      style: AppStyles.headingStyle.copyWith(fontSize: 24, color: AppStyles.dark),
                    ),
                    SizedBox(height: 20),
                    // MyTextField(
                    //   labelText: "Full Name",
                    //   icon: Icons.person,
                    // ),
                    // SizedBox(height: AppStyles.spaceS),
                    // MyTextField(
                    //   labelText: "Username",
                    //   icon: Icons.alternate_email,
                    // ),
                    // SizedBox(height: AppStyles.spaceS),
                    // MyTextField(
                    //   labelText: "Email",
                    //   icon: Icons.email_outlined,
                    // ),
                    // SizedBox(height: AppStyles.spaceS),
                    // MyTextField(
                    //   labelText: "Password",
                    //   icon: Icons.lock,
                    //   isPassword: true,
                    // ),
                    SizedBox(height: AppStyles.spaceL),
                    ReuseButton(
                      text: 'Daftar',
                      onPressed: () {
                        // controller.goToSignIn();
                        Get.offAllNamed(Routes.main);
                      },
                      backgroundColor: AppStyles.primary,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Selamat Mendaftar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun? '),
                  GestureDetector(
                    onTap: () {
                      // controller.goToSignUp();
                      Get.toNamed(Routes.signin);
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(color: AppStyles.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}