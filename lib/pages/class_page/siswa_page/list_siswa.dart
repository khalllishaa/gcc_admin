import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/StudentCard.dart';
import 'package:get/get.dart';

import '../../../controllers/class_controller.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({super.key});

  @override
  Widget build(BuildContext context) {
    ClassController controller = Get.find();

    return Scaffold(
      backgroundColor: AppStyles.light,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppStyles.radius),
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
                      ),
                    ),
                    SizedBox(width: AppStyles.spaceS),
                    Expanded(
                      child: Obx(() {
                        return CategoriesLine(
                          image: 'images/categories.png',
                          title: controller.selectedClassName.isEmpty
                              ? 'Class'
                              : controller.selectedClassName.value,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),

                // Displaying students for the selected class
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.studentsList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: AppStyles.spaceeXL),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.asset(
                              'images/motorcycle.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: AppStyles.spaceM),
                          Text(
                            'Tidak ada siswa di kelas ini',
                            style: AppStyles.profileText2,
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(
                      controller.studentsList.length,
                          (index) {
                        final student = controller.studentsList[index];
                        return StudentCard(
                          name: student.name,
                          onEdit: () => Get.toNamed('/edit-siswa', arguments: student),
                          onDelete: () {
                            controller.deleteStudent(student.id);
                          },
                          onTap: () => Get.toNamed('/list-report'),
                        );
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-siswa'),
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}