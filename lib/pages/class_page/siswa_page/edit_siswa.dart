import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/InputCard.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:get/get.dart';

import '../../../components/CustomTextField.dart';
import '../../../components/ReuseButton.dart';
import '../../home_page/teacher/add_teacher/add_teacher.dart';

class EditStudent extends StatelessWidget {
  const EditStudent({super.key});

  @override
  Widget build(BuildContext context) {
    MainMenuController mainMenuController = Get.find();

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
                        icon: Icon(Icons.arrow_back, color:AppStyles.light),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    SizedBox(width: AppStyles.spaceS),
                    Expanded(
                      child: CategoriesLine(
                        image: 'images/categories.png',
                        title: 'Edit Siswa',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),
                SizedBox(height: AppStyles.spaceM),
                buildSectionTitle('Nama'),
                SizedBox(height: AppStyles.spaceS),
                Customtextfield(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.text,
                  hintText: 'Syifa',
                ),
                SizedBox(height: AppStyles.spaceL),
                ReuseButton(
                  text: 'Edit Student',
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
