import 'package:flutter/material.dart';
import 'package:gcc_admin/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/ClassCard.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import '../../controllers/class_controller.dart';
import '../../components/WelcomeSign.dart';
import '../../components/AppStyles.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    ClassController controller = Get.find();
    ProfileController userController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              final user = userController.user.value;
              return WelcomeSign(
                username: user != null ? user.name : 'Guest',
                profileUrl: (user != null && user.profilePicture != null && user.profilePicture!.isNotEmpty)
                    ? 'https://gcc-api.rplrus.com/${user.profilePicture}'
                    : null,
              );
            }),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL),
                child: Obx(() {
                  return RefreshIndicator(
                    onRefresh: controller.getClasses,
                    child: controller.isLoading.value
                        ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 200),
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                        : controller.classList.isEmpty
                        ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 50),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.height * 0.3,
                                child: Image.asset(
                                  'images/motorcycle.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: AppStyles.spaceM),
                              Text(
                                'Tidak ada kelas tersedia',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppStyles.primaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                        : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: AppStyles.spaceS),
                      itemCount: controller.classList.length,
                      itemBuilder: (context, index) {
                        final kelas = controller.classList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: AppStyles.spaceS),
                          child: GestureDetector(
                            onTap: () {
                              controller.getStudents(kelas.id);
                              Get.toNamed('/list-siswa');
                            },
                            child: KelasCard(
                              imagePath: 'images/maths.png',
                              title: kelas.name,
                              avatarImagePaths: [
                                'images/categories.png',
                                'images/learning.png',
                                'images/logo_gcc.png',
                              ],
                              onDelete: () {
                                controller.deleteClass(kelas.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-class'),
        backgroundColor: AppStyles.dark,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}