import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/components/TextField2.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:get/get.dart';

class AddJournal extends StatelessWidget {
  const AddJournal({super.key});

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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppStyles.primaryDark,
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
                      title: 'Add Journal',
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
                      hintText: 'Topic',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('List Student'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'List Student',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Task'),
                    SizedBox(height: AppStyles.spaceS),
                    Textfield2(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: "Task",
                      onUploadPressed: () {
                      },
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