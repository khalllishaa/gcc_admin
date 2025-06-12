import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:get/get.dart';
import '../../components/CustomTextField.dart';
import '../../components/ReuseButton.dart';
import '../home_page/teacher/add_teacher.dart';

class EditClass extends StatelessWidget {
  const EditClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
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
                        icon: Icon(Icons.arrow_back, color: AppStyles.dark),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    SizedBox(width: AppStyles.spaceS),
                    Expanded(
                      child: CategoriesLine(
                        image: 'images/categories.png',
                        title: 'Edit Class',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),
                SectionTitle(title: 'Nama'),
                SizedBox(height: AppStyles.spaceS),
                Customtextfield(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.text,
                  hintText: 'Kelas 10',
                ),
                SizedBox(height: AppStyles.spaceL),
                ReuseButton(
                  text: 'Edit Class',
                  onPressed: () => Get.back(),
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
