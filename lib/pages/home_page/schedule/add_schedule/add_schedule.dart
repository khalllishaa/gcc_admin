import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:gcc_admin/pages/home_page/teacher/add_teacher/add_teacher.dart';
import 'package:get/get.dart';

class AddSchedule extends StatelessWidget {
  const AddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    MainMenuController mainMenuController = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      color: Color.fromRGBO(0, 151, 159, 1),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppStyles.light),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CategoriesLine(
                      title: 'Add Schedule',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle('Day'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'Day',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Time'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'Time',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Teacher'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'Teacher',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Subject'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'Subject',
                    ),
                    SizedBox(height: AppStyles.spaceL),
                    ReuseButton(
                      text: 'Add Schedule',
                      onPressed: () => Get.back(),
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

Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}