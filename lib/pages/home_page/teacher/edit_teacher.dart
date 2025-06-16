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
    final ListTeacherController controller = Get.find();
    final teacher = Get.arguments;

    final TextEditingController teacherNameController =
    TextEditingController(text: teacher.name);

    String status = teacher.status ?? 'active';

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
                  text: 'Edit Nama Guru',
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
                      Get.back();
                      Get.snackbar(
                        'Sukses',
                        'Nama guru berhasil diperbarui!',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.welcome,
                        colorText: AppStyles.dark,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Failed',
                        'Gagal memperbarui nama guru: $e',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.error,
                        colorText: AppStyles.light,
                      );
                    }
                  },
                ),

                SizedBox(height: AppStyles.spaceM),
                ReuseButton(
                  text: 'Ubah Status (${status == 'active' ? 'inactive' : 'active'})',
                  onPressed: () async {
                    String newStatus = status == 'active' ? 'inactive' : 'active';
                    try {
                      await controller.updateTeacherStatus(teacher.id, newStatus);
                      await Future.delayed(Duration(milliseconds: 500));
                      Get.back();
                      Get.snackbar(
                        'Sukses',
                        'Status guru diubah menjadi $newStatus',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.welcome,
                        colorText: AppStyles.dark,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Gagal mengubah status: $e',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.error,
                        colorText: AppStyles.light,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
