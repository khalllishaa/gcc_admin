import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/class_card.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    MainMenuController mainMenuController = Get.find();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: AppStyles.spaceXXL),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 151, 159, 1),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppStyles.light),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CategoriesLine(
                    title: 'Choose Class',
                    image: 'images/categories.png',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.toNamed('/view-schedule'),
              child: KelasCard(
                imagePath: 'images/maths.png',
                title: 'Kelas 8.1',
                avatarImagePaths: [
                  'images/categories.png',
                  'images/learning.png',
                  'images/logo_gcc.png',
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.toNamed('/view-schedule'),
              child: KelasCard(
                imagePath: 'images/maths.png',
                title: 'Kelas 8.1',
                avatarImagePaths: [
                  'images/categories.png',
                  'images/learning.png',
                  'images/logo_gcc.png',
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.toNamed('/view-schedule'),
              child: KelasCard(
                imagePath: 'images/maths.png',
                title: 'Kelas 8.1',
                avatarImagePaths: [
                  'images/categories.png',
                  'images/learning.png',
                  'images/logo_gcc.png',
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.toNamed('/view-schedule'),
              child: KelasCard(
                imagePath: 'images/maths.png',
                title: 'Kelas 8.1',
                avatarImagePaths: [
                  'images/categories.png',
                  'images/learning.png',
                  'images/logo_gcc.png',
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
