import 'package:flutter/material.dart';
import 'package:gcc_admin/controllers/list_teacher_controller.dart';
import 'package:gcc_admin/data/services/teacher_service.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';

class Addteacher extends StatelessWidget {
  Addteacher({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController classIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ListTeacherController controller = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                  ),
                  SizedBox(width: AppStyles.spaceS),
                  Expanded(
                    child: CategoriesLine(
                      title: 'Add Teacher',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'Nama'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      hintText: 'Nama Guru',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'ID Kelas'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: classIdController,
                      keyboardType: TextInputType.number,
                      hintText: 'Contoh: 1',
                    ),
                    SizedBox(height: AppStyles.spaceL),
                    ReuseButton(
                      text: 'Add Teacher',
                      onPressed: () async {
                        final name = nameController.text.trim();
                        final classId =
                            int.tryParse(classIdController.text.trim()) ?? 0;

                        if (name.isEmpty || classId == 0) {
                          Get.snackbar('Validasi', 'Semua field harus diisi');
                        } else {
                          try {
                            await controller.addTeacher(name, classId);

                            Get.snackbar(
                              'Sukses',
                              'Guru berhasil ditambahkan!',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppStyles.welcome,
                              colorText: AppStyles.dark,
                              duration: Duration(seconds: 2),
                              margin: EdgeInsets.all(16),
                            );

                            Get.back(result: true);

                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Gagal menambahkan guru $e',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppStyles.error,
                              colorText: AppStyles.light,
                              duration: Duration(seconds: 2),
                              margin: EdgeInsets.all(16),
                            );
                          }
                        }
                      },
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
