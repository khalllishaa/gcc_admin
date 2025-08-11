import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/WelcomeSign.dart';
import 'package:gcc_admin/controllers/class_controller.dart';
import 'package:gcc_admin/controllers/splashscreen_controller.dart';
import 'package:gcc_admin/controllers/profile_controller.dart';
import 'package:gcc_admin/controllers/signIn_controller.dart';
import 'package:get/get.dart';

import '../../components/LessonCard.dart';
import '../../controllers/menu_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    ProfileController userController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final user = userController.user.value;
              return WelcomeSign(
                username: user != null ? user.name : 'Guest',
                profileUrl: (user != null && user.profilePicture != null && user.profilePicture!.isNotEmpty)
                    ? 'https://gcc-api.rplrus.com/${user.profilePicture}'
                    : null,
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppStyles.spaceS),
                  CategoriesLine(
                    title: 'Halaman Utama',
                    image: 'images/categories.png',
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: CategoriesLine(
                  //         title: 'Halaman Utama',
                  //         image: 'images/categories.png',
                  //       ),
                  //     ),
                  //     Column(
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () => Get.toNamed('/notif'),
                  //           child: Container(
                  //             margin: EdgeInsets.only(left: AppStyles.paddingS),
                  //             padding: EdgeInsets.all(AppStyles.paddingS),
                  //             decoration: BoxDecoration(
                  //               color: AppStyles.primaryDark,
                  //               shape: BoxShape.circle,
                  //             ),
                  //             child: Icon(
                  //               Icons.notifications,
                  //               color: Colors.white,
                  //               size: 24,
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(height: AppStyles.spaceS),
                  //       ],
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppStyles.spaceS),
                      WavyCard(
                        title: 'Daftar Guru',
                        onTap: () => Get.toNamed('/list-teacher'),
                      ),
                      WavyCard(
                        title: 'Jadwal Bimbel',
                        onTap: () => Get.toNamed('/schedule'),
                      ),
                      WavyCard(
                        title: 'Materi Kelas',
                        onTap: () => Get.toNamed('/journal-class'),
                      ),
                      WavyCard(
                        title: 'Mata Pelajaran',
                        onTap: () => Get.toNamed('/subject'),
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
