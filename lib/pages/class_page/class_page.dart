import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/class_card.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import '../../controllers/class_controller.dart';
import '../../components/WelcomeSign.dart';
import '../../components/AppStyles.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => WelcomeSign(
              username: controller.classList.isNotEmpty
                  ? controller.classList[0].users[0].name
                  : 'Guest',
            )),
            // Add Expanded with a padding to make content not too close to edges
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    padding: EdgeInsets.only(top: AppStyles.spaceS),
                    itemCount: controller.classList.length,
                    itemBuilder: (context, index) {
                      final kelas = controller.classList[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: AppStyles.spaceS),
                        child: GestureDetector(
                          onTap: () {
                            controller.getStudents(kelas.id);
                            Get.toNamed('/list-siswa');
                          },
                          child: KelasCard(
                            imagePath: 'images/maths.png',
                            title: kelas.name,
                            avatarImagePaths: [
                              'images/categories.png',
                              'images/learning.png',
                              'images/logo_gcc.png',
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
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
