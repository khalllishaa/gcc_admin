import 'package:flutter/material.dart';
import 'package:gcc_admin/controllers/list_teacher_controller.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';

class EditTeacher extends StatelessWidget {
  const EditTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListTeacherController>();
    final teacher = Get.arguments;
    TextEditingController teacherNameController = TextEditingController(text: teacher.name);

    return Scaffold(
      backgroundColor: AppStyles.light,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: CategoriesLine(
                        image: 'images/categories.png',
                        title: 'Edit Guru',
                      ),
                    ),
                  ],
                ),
                SectionTitle(title: 'Nama'),
                SizedBox(height: AppStyles.spaceS),
                Customtextfield(
                  controller: teacherNameController,
                  keyboardType: TextInputType.text,
                  hintText: 'Masukkan Nama Terbaru',
                ),

                SizedBox(height: AppStyles.spaceL),
                ReuseButton(
                  text: 'Edit Teacher',
                    onPressed: () async {
                      final updatedName = teacherNameController.text.trim();

                      if (updatedName.isEmpty) {
                        Get.snackbar(
                          'Validasi',
                          'Nama tidak boleh kosong',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: AppStyles.error,
                          colorText: AppStyles.light,
                        );
                        return;
                      }

                      try {
                        await controller.updateTeacher(teacher.id, updatedName);
                      } catch (e) {
                        Get.snackbar(
                          'Failed',
                          'Gagal memperbarui nama guru: $e',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: AppStyles.error,
                          colorText: AppStyles.light,
                        );
                        print('Error updating teacher: $e');
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
