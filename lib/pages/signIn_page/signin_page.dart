import 'package:flutter/material.dart';
import 'package:gcc_admin/controllers/signIn_controller.dart';
import 'package:get/get.dart';
import '../../components/AppStyles.dart';
import '../../components/ReuseButton.dart';
import '../../components/TextFiled.dart';
import '../../routes/app_route.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = Get.find();

    return Scaffold(
      backgroundColor: AppStyles.login,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: AppStyles.primary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppStyles.radius)),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppStyles.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppStyles.padding),
                    decoration: BoxDecoration(
                      color: AppStyles.light,
                      borderRadius: BorderRadius.circular(AppStyles.radiusXL),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: AppStyles.spaceS,
                          spreadRadius: AppStyles.spaceXXS,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Masuk',
                          style: AppStyles.headingStyle.copyWith(fontSize: 24, color: AppStyles.dark),
                        ),
                        SizedBox(height: AppStyles.spaceS),
                        Text(
                          'Silahkan isi terlebih dahulu sebelum masuk.',
                          textAlign: TextAlign.center,
                          style: AppStyles.profileText1.copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                        SizedBox(height: AppStyles.spaceM),
                        MyTextField(
                          labelText: "Username",
                          icon: Icons.person,
                          controller: controller.usernameController,
                        ),
                        SizedBox(height: AppStyles.spaceL),
                        MyTextField(
                          labelText: "Password",
                          icon: Icons.lock,
                          isPassword: true,
                          controller: controller.passwordController,
                        ),
                        SizedBox(height: AppStyles.spaceL),
                        ReuseButton(
                          text: 'Masuk',
                          onPressed: () {
                            controller.goToSignIn();
                          },
                          backgroundColor: AppStyles.schedule,
                          textColor: AppStyles.light,
                        ),
                        SizedBox(height: AppStyles.spaceS)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}