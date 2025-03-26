import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

class ClassCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const ClassCard({required this.title, required this.subtitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offNamed(Routes.main);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppStyles.paddingL),
        padding: EdgeInsets.all(AppStyles.paddingXL),
        height: 120,
        decoration: BoxDecoration(
          color: AppStyles.welcome,
          borderRadius: BorderRadius.circular(AppStyles.radiusL),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppStyles.heading1.copyWith(fontSize: 20),
                ),
                Text(
                  subtitle,
                  style: AppStyles.profileText1.copyWith(fontSize: 16),
                ),
              ],
            ),
            Image.asset(
              'images/learning.png',
              width: 70, // Perbesar ikon
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
