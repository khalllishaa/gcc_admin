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
        padding: EdgeInsets.all(16.0),
        child: Column(
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
                    constraints: BoxConstraints(),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CategoriesLine(
                    title: 'Teacher',
                    image: 'images/categories.png',
                  ),
                ),
              ],
            ),
            StudentCard(
              name: 'Guru 1',
              onEdit: () {},
              onDelete: () {},
              onMore: () =>
                  Get.toNamed('/list-report'),
            ),
            SizedBox(height: 8),
            StudentCard(
              name: 'Guru 2',
              onEdit: () {},
              onDelete: () {},
              onMore: () => Get.toNamed('/list-report'),
            ),
            SizedBox(height: 8),
            StudentCard(
              name: 'Guru 3',
              onEdit: () {},
              onDelete: () {},
              onMore: () => Get.toNamed('/list-report'),
            ),
            SizedBox(height: 8),
            StudentCard(
              name: 'Guru 4',
              onEdit: () {},
              onDelete: () {},
              onMore: () => Get.toNamed('/list-report'),
            ),
            SizedBox(height: 8),
            StudentCard(
              name: 'Guru 5',
              onEdit: () {},
              onDelete: () {},
              onMore: () => Get.toNamed('/list-report'),
            ),
            SizedBox(height: 8),
            StudentCard(
              name: 'Guru 6',
              onEdit: () {},
              onDelete: () {},
              onMore: () => Get.toNamed('/list-report'),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.addTeacher);
          },
          backgroundColor: AppStyles.primary,
          child: Icon(Icons.add_circle_outline, color: AppStyles.light),
        ),
      ),
    );
  }
}
