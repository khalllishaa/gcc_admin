import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/class_card.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';

import '../../routes/app_route.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CategoriesLine(
                  image: 'images/categories.png',
                  title: 'Kelas',
                ),
                SizedBox(
                  height: 20,
                ),
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
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Get.toNamed('/list-siswa'),
                  child: const KelasCard(
                    imagePath: 'images/maths.png',
                    title: 'Kelas 8.1',
                    avatarImagePaths: [
                      'images/categories.png',
                      'images/learning.png',
                      'images/logo_gcc.png',
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Get.toNamed('/list-siswa'),
                  child: const KelasCard(
                    imagePath: 'images/maths.png',
                    title: 'Kelas 8.2',
                    avatarImagePaths: [
                      'images/categories.png',
                      'images/learning.png',
                      'images/logo_gcc.png',
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.listTeacher);
                  },
                  child: const KelasCard(
                    imagePath: 'images/maths.png',
                    title: 'Kelas 9',
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-class'),
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromRGBO(55, 171, 177, 1)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
