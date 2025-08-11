import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:get/get.dart';

class WelcomeSign extends StatelessWidget {
  final String username;
  final String? profileUrl;

  const WelcomeSign({
    Key? key,
    required this.username,
    this.profileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        username.isNotEmpty ? username : 'Guest',
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
            // Profile Image
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
                    image: (profileUrl != null && profileUrl!.isNotEmpty)
                        ? NetworkImage(profileUrl!)
                        : AssetImage("images/profile.png") as ImageProvider,
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