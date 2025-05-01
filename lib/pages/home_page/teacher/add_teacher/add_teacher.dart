import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:get/get.dart';

class Addteacher extends StatelessWidget {
  const Addteacher({super.key});

  @override
  Widget build(BuildContext context) {
    MainMenuController mainMenuController = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.paddingL),
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
                      icon: Icon(Icons.arrow_back, color: AppStyles.light),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: AppStyles.spaceS),
                  Expanded(
                    child: CategoriesLine(
                      title: 'Add Teacher',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Nama'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'Guru 1',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('No Telp'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'No Telp',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    buildSectionTitle('Mata Pelajaran'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'Mengajar Mata Pelajaran',
                    ),
                    SizedBox(height: AppStyles.spaceL),
                    ReuseButton(
                      text: 'Add Teacher',
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
    padding: EdgeInsets.symmetric(vertical: AppStyles.paddingS),
    child: Text(
      title,
      style: AppStyles.welcome2.copyWith(color: AppStyles.dark, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
