import 'package:flutter/material.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:get/get.dart';

import '../../../components/AppStyles.dart';
import '../../../components/CategoriesLine.dart';
import '../../../components/CustomTextField.dart';
import '../../../controllers/menu_controller.dart';

class AddNotification extends StatelessWidget {
  const AddNotification({super.key});

  @override
  Widget build(BuildContext context) {

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
                      title: 'Add Notification',
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
                    SectionTitle(title: 'Add Notification'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      hintText: 'Buat Pengumuman',
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    ReuseButton(
                      text: 'Add Notification',
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