import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/TeachersCard.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

import '../../../controllers/list_teacher_controller.dart';
import '../../../components/StudentCard.dart';

class Listteacher extends StatelessWidget {
  const Listteacher({super.key});

  @override
  Widget build(BuildContext context) {
    ListTeacherController controller = Get.find();

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
                      onPressed: () => Get.toNamed('/main'),
                    ),
                  ),
                  SizedBox(width: AppStyles.spaceS),
                  Expanded(
                    child: CategoriesLine(
                      title: 'Daftar Guru',
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

                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchTeachers();
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.teachers.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: AppStyles.spaceS),
                      itemBuilder: (context, index) {
                        final teacher = controller.teachers[index];
                        return Teacherscard(
                          name: teacher.name,
                          status: teacher.status ?? '',
                          onEdit: () =>
                              Get.toNamed('/edit-teacher', arguments: teacher),
                          onDelete: () => controller.deleteTeacher(teacher.id),
                          onTap: () {},
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(Routes.addTeacher);
          if (result == true) {
            controller.fetchTeachers();
          }
        },
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
