import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/AppStyles.dart';
import '../../../components/CategoriesLine.dart';
import '../../../components/StudentCard.dart';
import '../../../routes/app_route.dart';
import '../../../controllers/subject_controller.dart';

class ViewSubject extends StatelessWidget {
  ViewSubject({super.key});

  final SubjectController controller = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppStyles.spaceXL),
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
                      onPressed: () => Get.toNamed('/main'),
                    ),
                  ),
                  SizedBox(width: AppStyles.spaceS),
                  Expanded(
                    child: CategoriesLine(
                      title: 'Subject',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppStyles.spaceM),

              // Wrap list with RefreshIndicator
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getSubjects();
                  },
                  child: Obx(() {
                    print("Is Loading: ${controller.isLoading.value}");
                    print("Subjects: ${controller.subjects}");

                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (controller.subjects.isEmpty) {
                      return ListView(
                        children: [
                          SizedBox(height: AppStyles.spaceeXL),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.asset(
                              'images/motorcycle.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: AppStyles.spaceM),
                          Center(
                            child: Text(
                              'Tidak ada subject di kelas ini',
                              style: AppStyles.profileText2,
                            ),
                          ),
                        ],
                      );
                    }

                    return ListView.separated(
                      itemCount: controller.subjects.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: AppStyles.spaceXXS),
                      itemBuilder: (context, index) {
                        final subject = controller.subjects[index];
                        return StudentCard(
                          name: subject.name,
                          icon: Icons.menu_book_rounded,
                          onEdit: () => Get.toNamed('/edit-subject', arguments: subject),
                          onDelete: () {
                            controller.deleteSubject(subject.id);
                          },
                          onTap: () {},
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addSubject);
        },
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
