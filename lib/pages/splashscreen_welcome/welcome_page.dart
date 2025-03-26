import 'package:flutter/material.dart';
import 'package:gcc_admin/components/ClassCard.dart';
import 'package:gcc_admin/controllers/welcome_controller.dart';
import 'package:get/get.dart';
import '../../components/AppStyles.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = Get.find();

    return Scaffold(
      backgroundColor: AppStyles.primary,
      body: Column(
        children: [
          SizedBox(height: AppStyles.spaceXXL),
          Center(
            child: Text(
              "Profile",
              style: AppStyles.headingStyle.copyWith(fontSize: 24),
            ),
          ),
          SizedBox(height: AppStyles.spaceL),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.radius)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClassCard(title: "Paket 1 bulan", subtitle: "Basic"),
                  ClassCard(title: "Paket 3 bulan", subtitle: "Advance"),
                  ClassCard(title: "Paket 5 bulan", subtitle: "Expert"),
                  ClassCard(title: "Paket 1 Tahun", subtitle: "Complete"),
                ],              ),
            ),
          ),
        ],
      ),
    );
  }
}