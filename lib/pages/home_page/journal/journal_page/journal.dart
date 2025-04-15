import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/JournalCard.dart';
import 'package:gcc_admin/components/class_card.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

import '../../../../controllers/menu_controller.dart';

class Journal extends StatelessWidget {
  const Journal({super.key});

  @override
  Widget build(BuildContext context) {
    MainMenuController mainMenuController = Get.find();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
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
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
                SizedBox(width: AppStyles.spaceS),
                Expanded(
                  child:
                  CategoriesLine(
                    title: 'Journal',
                    image: 'images/categories.png',
                  ),
                ),
              ],
            ),
            SizedBox(height: AppStyles.spaceS),
            GestureDetector(
              onTap: () => Get.toNamed('/view-journal'),
              child: CourseCard(
                title: "Bahasa Inggris",
                subtitle: "Proposal",
                imagePath: "images/student.png",
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: AppStyles.paddingL, right: AppStyles.paddingL),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.addJournal);
          },
          backgroundColor: AppStyles.primary,
          child: Icon(Icons.add_circle_outline, color: AppStyles.light),
        ),
      ),
    );
  }
}
