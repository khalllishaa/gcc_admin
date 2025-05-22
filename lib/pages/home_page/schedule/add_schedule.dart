import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:gcc_admin/controllers/schedule_controller.dart';
import 'package:get/get.dart';

class AddSchedule extends StatelessWidget {
  const AddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleController controller = Get.find();

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
                    SectionTitle(title: 'Day'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: dayController,
                      keyboardType: TextInputType.text,
                      hintText: 'Day',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'Time'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: timeController,
                      keyboardType: TextInputType.text,
                      hintText: 'Time',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'Teacher'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: teacherController,
                      keyboardType: TextInputType.text,
                      hintText: 'Teacher',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'Subject'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: subjectController,
                      keyboardType: TextInputType.text,
                      hintText: 'Subject',
                    ),
                    SizedBox(height: AppStyles.spaceL),
                    ReuseButton(
                      text: 'Add Schedule',
                        onPressed: () async {
                          final day = dayController.text.trim();
                          final time = timeController.text.trim();
                          final teacher = teacherController.text.trim();
                          final subject = subjectController.text.trim();

                          if (day.isEmpty || time.isEmpty || teacher.isEmpty || subject.isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Semua field harus diisi.',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppStyles.error,
                              colorText: AppStyles.light,
                              duration: Duration(seconds: 2),
                              margin: EdgeInsets.all(16),
                            );
                          } else {
                            await controller.addSchedule(
                              day: day,
                              time: time,
                              teacher: teacher,
                              subject: subject,
                            );
                            Get.back();
                            Get.snackbar(
                              'Sukses',
                              'Schedule berhasil ditambahkan!',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppStyles.welcome,
                              colorText: AppStyles.dark,
                              duration: Duration(seconds: 2),
                              margin: EdgeInsets.all(16),
                            );
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