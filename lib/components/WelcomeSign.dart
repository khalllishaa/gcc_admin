import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class WelcomeSign extends StatelessWidget {
  const WelcomeSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    MainMenuController mainMenuController = Get.find();

    return Container(
      width: double.infinity,
      height: 110,
      child: Container(
        width: double.infinity,
        height: AppStyles.profile,
        margin: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
        child: Row(
          children: [
            SizedBox(width: AppStyles.spaceXS),
            // Welcome Text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hello!',
                        style: AppStyles.heading1,
                      ),
                      SizedBox(width: AppStyles.spaceS),
                      Text(
                        controller.userName,
                        style: AppStyles.heading1,
                      ),
                    ],
                  ),
                  SizedBox(height: AppStyles.spaceXS),
                  Text(
                    'Welcome to GCC',
                    style: AppStyles.heading2,
                  ),
                ],
              ),
            ),
            SizedBox(width: AppStyles.paddingXL),
            // Logo
            GestureDetector(
              onTap: () {
                mainMenuController.updateIndex(2);
              },
              child: Container(
                width: AppStyles.logoHeading,
                height: AppStyles.logoHeading,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("images/profile.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
