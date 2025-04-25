import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/StudentCard.dart';
import 'package:get/get.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.light,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppStyles.radius),
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
                        image: 'images/categories.png',
                        title: 'Kelas',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),
                StudentCard(
                  name: 'Ocean',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Jadin',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Khalisha',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Syifa',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Keanu',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Khansa',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Jeri',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Kafka',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
                StudentCard(
                  name: 'Audine',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onTap: () => Get.toNamed('/list-report'),
                ),
                SizedBox(height: AppStyles.spaceS),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-siswa'),
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
