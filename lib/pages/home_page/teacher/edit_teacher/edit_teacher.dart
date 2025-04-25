import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:get/get.dart';

import '../../../../components/ReuseButton.dart';
import '../add_teacher/add_teacher.dart';

class EditTeacher extends StatelessWidget {
  const EditTeacher({super.key});

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: AppStyles.spaceM),
                buildSectionTitle('Nama'),
                Customtextfield(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.text,
                  hintText: 'Miss Ica',
                ),
                SizedBox(height: AppStyles.spaceL),
                ReuseButton(
                  text: 'Edit Teacher',
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
