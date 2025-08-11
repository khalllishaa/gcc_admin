import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:get/get.dart';
import '../../../components/CustomTextField.dart';
import '../../../components/ReuseButton.dart';
import '../../../controllers/class_controller.dart';
import '../../home_page/teacher/add_teacher.dart';

class EditStudent extends StatelessWidget {
  const EditStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final student = Get.arguments;
    ClassController controller = Get.find();
    TextEditingController studentNameController = TextEditingController(text: student.name);

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
                        title: 'Edit Data Siswa',
                      ),
                    ),
                  ],
                ),
                SectionTitle(title: 'Nama'),
                SizedBox(height: AppStyles.spaceS),
                Customtextfield(
                  controller: studentNameController,
                  keyboardType: TextInputType.text,
                  hintText: 'Masukkan Nama Terbaru',
                ),

                SizedBox(height: AppStyles.spaceL),
                ReuseButton(
                  text: 'Edit Data Siswa',
                  onPressed: () async {
                    final updatedName = studentNameController.text;

                    try {
                      await controller.updateStudentName(student.id, updatedName);
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Student name updated successfully',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.welcome,
                        colorText:AppStyles.dark,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Failed',
                        'Failed to update student name because it already exists',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.error,
                        colorText: AppStyles.light,
                      );
                      print('Error updating student: $e');
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