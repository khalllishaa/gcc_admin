import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ScheduleCard.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

class ViewSchedule extends StatelessWidget {
  const ViewSchedule({super.key});

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
                  child: CategoriesLine(
                    title: 'Schedule',
                    image: 'images/categories.png',
                  ),
                ),
              ],
            ),
            Padding(
              // padding: EdgeInsets.all(AppStyles.paddingL),
              padding: EdgeInsets.only(left: AppStyles.paddingL, right: AppStyles.paddingL),
                child: Column(
                  children: [
                    ScheduleCard(
                      day: "Tuesday",
                      subject: "Matematika",
                      time: "13.00 - 14.30",
                      teacher: "Miss Ica",
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    ScheduleCard(
                      day: "Tuesday",
                      subject: "Matematika",
                      time: "13.00 - 14.30",
                      teacher: "Miss Ica",
                    ),
                    SizedBox(height: AppStyles.spaceM),
                  ],
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
            Get.toNamed(Routes.addSchedule);
          },
          backgroundColor: AppStyles.primary,
          child: Icon(Icons.add_circle_outline, color: AppStyles.light),
        ),
      ),
    );
  }
}
