import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/class_card.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';

import '../../components/WelcomeSign.dart';
import '../../routes/app_route.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            WelcomeSign(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingM),
              child: Column(
                children: [
                  SizedBox(height: AppStyles.space),
                  CategoriesLine(
                    image: 'images/categories.png',
                    title: 'Kelas',
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
                  child: Column(
                    children: [
                      SizedBox(height: AppStyles.space),
                      GestureDetector(
                        onTap: () => Get.toNamed('/list-siswa'),
                        child: KelasCard(
                          imagePath: 'images/maths.png',
                          title: 'Kelas 7',
                          avatarImagePaths: [
                            'images/categories.png',
                            'images/learning.png',
                            'images/logo_gcc.png',
                          ],
                          onEdit: () => Get.toNamed('/edit-class'),
                        ),
                      ),
                      SizedBox(height: AppStyles.spaceS),
                      GestureDetector(
                        onTap: () => Get.toNamed('/list-siswa'),
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
                      SizedBox(height: AppStyles.spaceS),
                      GestureDetector(
                        onTap: () => Get.toNamed('/list-siswa'),
                        child: KelasCard(
                          imagePath: 'images/maths.png',
                          title: 'Kelas 8.2',
                          avatarImagePaths: [
                            'images/categories.png',
                            'images/learning.png',
                            'images/logo_gcc.png',
                          ],
                        ),
                      ),
                      SizedBox(height: AppStyles.spaceS),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.listTeacher),
                        child: KelasCard(
                          imagePath: 'images/maths.png',
                          title: 'Kelas 9',
                          avatarImagePaths: [
                            'images/categories.png',
                            'images/learning.png',
                            'images/logo_gcc.png',
                          ],
                        ),
                      ),
                      SizedBox(height: AppStyles.spaceL),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-class'),
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
