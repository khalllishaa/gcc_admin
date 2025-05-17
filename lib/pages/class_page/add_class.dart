import 'package:flutter/material.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:get/get.dart';

import '../../components/AppStyles.dart';
import '../../controllers/class_controller.dart';
import '../home_page/teacher/add_teacher/add_teacher.dart';

class AddClass extends StatelessWidget {
  const AddClass({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassController());

    return Scaffold(
      backgroundColor: Colors.white,
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
                        title: 'Add Class',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),
                SectionTitle(title: 'Nama'),
                SizedBox(height: AppStyles.spaceS),
                Customtextfield(
                  controller: controller.classNameController,  // Menggunakan controller untuk textfield
                  keyboardType: TextInputType.text,
                  hintText: 'Nama Kelas',
                ),
                SizedBox(height: AppStyles.spaceL),
                ReuseButton(
                  text: 'Add Class',
                  onPressed: () {
                    controller.addClass();  // Panggil method addClass dari controller
                  },
                ),
                SizedBox(height: AppStyles.spaceS),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
