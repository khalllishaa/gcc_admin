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
        padding: EdgeInsets.all(AppStyles.paddingL),
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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppStyles.primaryDark,
                      borderRadius: BorderRadius.circular(AppStyles.radiusL),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_today, color: AppStyles.light, size: AppStyles.iconL),
                        SizedBox(width: AppStyles.spaceS),
                        Text(
                          "13 Januari",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppStyles.spaceM),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addJournal);
        },
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
