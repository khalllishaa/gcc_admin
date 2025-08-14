import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/StudentCard.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../controllers/class_controller.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({super.key});

  // Function to save student data to SharedPreferences
  Future<void> _saveStudentToPreferences(dynamic student) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convert student object to JSON string
      String studentJson = jsonEncode({
        'id': student.id,
        'name': student.name,
        // Add other student properties as needed
        // 'email': student.email,
        // 'class': student.class,
      });

      await prefs.setString('selected_student', studentJson);
      print('Student saved to SharedPreferences: $studentJson');
    } catch (e) {
      print('Error saving student to SharedPreferences: $e');
    }
  }

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
                              ? 'Kelas'
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
                          // Updated onTap to save to SharedPreferences
                          onTap: () async {
                            await _saveStudentToPreferences(student);
                            Get.toNamed('/list-report');
                          },
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