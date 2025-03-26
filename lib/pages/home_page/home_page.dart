import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/WelcomeSign.dart';
import 'package:gcc_admin/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../components/ClassCard.dart';
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
              padding: EdgeInsets.only(left: AppStyles.paddingL, right: AppStyles.paddingL),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CategoriesLine(
                            title: 'Kelas 8 SMP',
                            image: 'images/categories.png',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppStyles.paddingS),
                          padding: EdgeInsets.all(AppStyles.paddingS),
                          decoration: BoxDecoration(
                            color: AppStyles.primaryDark,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    LessonCard(
                      title: 'Journall',
                      lessonCount: '13 Lesson',
                      imagePath: 'images/student.png',
                      backgroundColor: AppStyles.secondary,
                      onTap: () {
                        mainMenuController.updateIndex(2);
                      },
                    ),
                    SizedBox(height: AppStyles.spaceXL),
                    CategoriesLine(
                      title: 'Daily Schedule',
                      image: 'images/learning.png',
                    ),
                    // Expanded(
                    //   child: Obx(() => ListView.separated(
                    //     padding: EdgeInsets.symmetric(horizontal: 0),
                    //     physics: BouncingScrollPhysics(),
                    //     itemCount: controller.classData.length,
                    //     separatorBuilder: (context, index) => SizedBox(height: AppStyles.spaceXXS),
                    //     itemBuilder: (context, index) {
                    //       return Align(
                    //         alignment: Alignment.center,
                    //         child: ClassCard(
                    //           title: controller.classData[index]["title"],
                    //           teacher: controller.classData[index]["teacher"],
                    //           time: controller.classData[index]["time"],
                    //           topic: controller.classData[index]["topic"],
                    //           icon: controller.classData[index]["icon"],
                    //         ),
                    //       );
                    //     },
                    //   )),
                    // ),
                    // ClassCard(
                    //     title: 'Matematika',
                    //     teacher: 'Miss Ica',
                    //     time: '13.00-14.30',
                    //     topic: 'Kombinasi',
                    //     icon: Icons.menu_book_rounded),
                    // ClassCard(
                    //     title: 'Bahasa Inggris',
                    //     teacher: 'Miss Ica',
                    //     time: '13.00-14.30',
                    //     topic: 'Proposal',
                    //     icon: Icons.menu_book_rounded),
                    LessonCard(
                      title: 'Report',
                      lessonCount: '13 Lesson',
                      imagePath: 'images/student.png',
                      backgroundColor: AppStyles.secondary,
                      onTap: () {
                        mainMenuController.updateIndex(2);
                      },
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
