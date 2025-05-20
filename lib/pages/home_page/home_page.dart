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

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => WelcomeSign(
              username: controller.classList.isNotEmpty
                  ? controller.classList[0].users[0].name
                  : 'Guest',
            )),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppStyles.space),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CategoriesLine(
                              title: 'Home Page',
                              image: 'images/categories.png',
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed('/notif'),
                                child: Container(
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
                              ),
                              SizedBox(height: AppStyles.spaceS),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: AppStyles.spaceS),
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
            ),
          ],
        ),
      ),
    );
  }
}
