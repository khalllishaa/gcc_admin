import 'package:flutter/material.dart';
import 'package:gcc_admin/api_models/schedule_models.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:gcc_admin/pages/home_page/teacher/add_teacher/add_teacher.dart';
import 'package:get/get.dart';

import '../../../../controllers/class_controller.dart';

class AddSchedule extends StatelessWidget {
  const AddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    MainMenuController mainMenuController = Get.find();
    final controller = Get.find<ClassController>();

    final dayController = TextEditingController();
    final timeController = TextEditingController();
    final teacherController = TextEditingController();
    final subjectController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppStyles.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppStyles.spaceXXL),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppStyles.primaryDark,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppStyles.light),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  SizedBox(width: AppStyles.spaceS),
                  Expanded(
                    child: CategoriesLine(
                      title: 'Add Schedule',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle('Day'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: dayController,
                      keyboardType: TextInputType.text,
                      hintText: 'Day',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Time'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: timeController,
                      keyboardType: TextInputType.text,
                      hintText: 'Time',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Teacher'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: teacherController,
                      keyboardType: TextInputType.text,
                      hintText: 'Teacher',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Subject'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: subjectController,
                      keyboardType: TextInputType.text,
                      hintText: 'Subject',
                    ),
                    SizedBox(height: AppStyles.spaceL),
                    ReuseButton(
                      text: 'Add Schedule',
                        onPressed: () {
                          final day = dayController.text.trim();
                          final time = timeController.text.trim();
                          final teacher = teacherController.text.trim();
                          final subject = subjectController.text.trim();

                          if (day.isEmpty || time.isEmpty || teacher.isEmpty || subject.isEmpty) {
                            Get.snackbar('Validasi', 'Semua field harus diisi');

                          } else {
                            controller.addSchedule(
                              day: day,
                              time: time,
                              teacher: teacher,
                              subject: subject,
                            );
                            Get.back();
                          }
                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
