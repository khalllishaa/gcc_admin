import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/ClassCard.dart';
import 'package:gcc_admin/controllers/class_controller.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:gcc_admin/controllers/schedule_controller.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

class ClassSchedule extends StatelessWidget {
  const ClassSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    ClassController controller = Get.find();
    ScheduleController scheduleController = Get.find();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppStyles.paddingL),
        child: Column(
          children: [
            SizedBox(height: AppStyles.spaceXXL),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyles.primaryDark,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppStyles.light),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
                SizedBox(width: AppStyles.spaceS),
                Expanded(
                  child: CategoriesLine(
                    title: 'Choose Class',
                    image: 'images/categories.png',
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.classList.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada kelas tersedia',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppStyles.primaryDark,
                        ),
                      ),
                    );
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
                            scheduleController.selectedClassId.value = kelas.id;
                            Get.toNamed('/view-schedule');
                          },
                          child: KelasCard(
                            imagePath: 'images/maths.png',
                            title: kelas.name,
                            avatarImagePaths: [
                              'images/categories.png',
                              'images/learning.png',
                              'images/logo_gcc.png',
                            ],
                            onDelete: () {},
                            showDeleteIcon: false
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
    );
  }
}