import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/WelcomeSign.dart';
import 'package:gcc_admin/controllers/class_controller.dart';
import 'package:gcc_admin/controllers/home_controller.dart';
import 'package:gcc_admin/controllers/welcome_controller.dart';
import 'package:get/get.dart';

import '../../components/LessonCard.dart';
import '../../controllers/menu_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    ClassController controller = Get.find();
    MainMenuController mainMenuController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => WelcomeSign(
                  username: controller.classList.isNotEmpty
                      ? controller.classList[0].users[0].name
                      : 'Admin',
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppStyles.space),
                  CategoriesLine(
                    title: 'Home Page',
                    image: 'images/categories.png',
                  ),
                  SizedBox(height: AppStyles.spaceS),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
                child: Column(
                  children: [
                    WavyCard(
                      title: 'List Guru',
                      onTap: () => Get.toNamed('/list-teacher'),
                    ),
                    WavyCard(
                      title: 'Jadwal Mata Pelajaran',
                      onTap: () => Get.toNamed('/schedule'),
                    ),
                    WavyCard(
                      title: 'Journal Kelas',
                      onTap: () => Get.toNamed('/journal-class'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
