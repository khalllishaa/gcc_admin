import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/ClassCard.dart';
import 'package:get/get.dart';

import '../../../controllers/class_controller.dart';

class JournalClass extends StatelessWidget {
  const JournalClass({super.key});

  @override
  Widget build(BuildContext context) {
    final classC = Get.put(ClassController());

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
                  decoration: const BoxDecoration(
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
                    title: 'Pilih Kelas',
                    image: 'images/categories.png',
                  ),
                ),
              ],
            ),
            SizedBox(height: AppStyles.spaceS),

            // WRAP LIST DENGAN SCROLLABLE
            Expanded(
              child: Obx(() => SingleChildScrollView(
                child: Column(
                  children: classC.classList.map((kelas) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed('/journal', arguments: {
                            'classId': kelas.id,
                            'className': kelas.name,
                          }),
                          child: KelasCard(
                              imagePath: 'images/maths.png',
                              title: kelas.name,
                              avatarImagePaths: [
                                'images/categories.png',
                                'images/learning.png',
                                'images/logo_gcc.png',
                              ],
                              onDelete: () {},
                              showDeleteIcon: false

                          ),
                        ),
                        SizedBox(height: AppStyles.spaceS),
                      ],
                    );
                  }).toList(),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
