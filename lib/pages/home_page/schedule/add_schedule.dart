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
                    Obx(() => DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Select Day',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      value: controller.selectedDay.value.isEmpty
                          ? null
                          : controller.selectedDay.value,
                      items: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu']
                          .map((day) => DropdownMenuItem(
                        value: day,
                        child: Text(
                          day,
                          style: TextStyle(fontSize: 14),
                        ),
                      ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedDay.value = value ?? '';
                      },
                    )),

                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'Time'),
                    SizedBox(height: AppStyles.spaceS),
                    Obx(() => GestureDetector(
                      onTap: () => controller.pickTimeRange(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.selectedTime.value.isEmpty
                                  ? 'Select Time'
                                  : controller.selectedTime.value,
                              style: TextStyle(
                                fontSize: 14,
                                color: controller.selectedTime.value.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            Icon(Icons.access_time, color: Colors.grey),
                          ],
                        ),
                      ),
                    )),
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
                          final day = controller.selectedDay.value;
                          final time = controller.selectedTime.value;
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
                            controller.selectedDay.value = '';
                            controller.selectedTime.value = '';
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
