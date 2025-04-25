import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

import '../../../../controllers/menu_controller.dart';
import '../../../../components/StudentCard.dart';

class Listteacher extends StatelessWidget {
  const Listteacher({super.key});

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
                  ),
                ),
                SizedBox(width: AppStyles.spaceS),
                Expanded(
                  child: CategoriesLine(
                    title: 'Teacher',
                    image: 'images/categories.png',
                  ),
                ),
              ],
            ),
            SizedBox(height: AppStyles.spaceL),
            StudentCard(
              name: 'Miss Ica',
              onEdit: () => Get.toNamed('/edit-teacher'),
              onDelete: () {},
              onTap: () {  },
            ),
            SizedBox(height: AppStyles.spaceS),
            StudentCard(
              name: 'Miss Candra',
              onEdit: () => Get.toNamed('/edit-teacher'),
              onDelete: () {},
              onTap: () {  },
            ),
            SizedBox(height: AppStyles.spaceS),
            StudentCard(
              name: 'Miss Sari',
              onEdit: () => Get.toNamed('/edit-teacher'),
              onDelete: () {},
              onTap: () {  },
            ),
            SizedBox(height: AppStyles.spaceS),
            StudentCard(
              name: 'Miss Ima',
              onEdit: () => Get.toNamed('/edit-teacher'),
              onDelete: () {},
              onTap: () {  },
            ),
            SizedBox(height: AppStyles.spaceS),
            StudentCard(
              name: 'Miss Fani',
              onEdit: () => Get.toNamed('/edit-teacher'),
              onDelete: () {},
              onTap: () {  },
            ),
            SizedBox(height: AppStyles.spaceS),
            StudentCard(
              name: 'Miss Sinta',
              onEdit: () => Get.toNamed('/edit-teacher'),
              onDelete: () {},
              onTap: () {  },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addTeacher);
        },        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
