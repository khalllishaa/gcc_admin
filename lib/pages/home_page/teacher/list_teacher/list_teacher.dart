import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

import '../../../../controllers/list_teacher_controller.dart';
import '../../../../components/StudentCard.dart';

class Listteacher extends StatelessWidget {
  const Listteacher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListTeacherController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: Column(
            children: [
              SizedBox(height: AppStyles.spaceXL),
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
                    child: CategoriesLine(
                      title: 'Teacher',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppStyles.spaceL),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.separated(
                    itemCount: controller.teachers.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: AppStyles.spaceS),
                    itemBuilder: (context, index) {
                      final teacher = controller.teachers[index];
                      return StudentCard(
                        name: teacher.name,
                        onEdit: () => Get.toNamed('/edit-teacher', arguments: teacher),
                        onDelete: () => controller.deleteTeacher(teacher.id),
                        onTap: () {},
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addTeacher);
        },
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
