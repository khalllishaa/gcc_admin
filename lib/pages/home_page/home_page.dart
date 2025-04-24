import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/WelcomeSign.dart';
import 'package:gcc_admin/controllers/home_controller.dart';
import 'package:get/get.dart';


import '../../components/LessonCard.dart';
import '../../controllers/menu_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // WelcomeController controller = Get.put(WelcomeController());
    HomeController controller = Get.find();
    MainMenuController mainMenuController = Get.find();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: AppStyles.space),
            WelcomeSign(),
            SizedBox(height: AppStyles.spaceL),
            Padding(
              padding: EdgeInsets.only(left: AppStyles.paddingXL, right: AppStyles.paddingXL),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CategoriesLine(
                      title: 'Home Page',
                      image: 'images/categories.png',
                    ),
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
