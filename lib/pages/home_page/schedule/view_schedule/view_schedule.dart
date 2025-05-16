  import 'package:flutter/material.dart';
  import 'package:gcc_admin/components/AppStyles.dart';
  import 'package:gcc_admin/components/CategoriesLine.dart';
  import 'package:gcc_admin/components/CustomTextField.dart';
  import 'package:gcc_admin/components/ScheduleCard.dart';
  import 'package:gcc_admin/controllers/menu_controller.dart';
  import 'package:gcc_admin/routes/app_route.dart';
  import 'package:get/get.dart';

  import '../../../../controllers/class_controller.dart';

  class ViewSchedule extends StatelessWidget {
    const ViewSchedule({super.key});

    @override
    Widget build(BuildContext context) {
      final controller = Get.find<ClassController>();
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
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.scheduleList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        Text(
                          'Tidak ada jadwal di kelas ini',
                          style: AppStyles.profileText2,
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: List.generate(
                    controller.scheduleList.length,
                        (index) {
                      final schedule = controller.scheduleList[index];
                      return ScheduleCard(
                        day: schedule.day,
                        subject: schedule.subject,
                        time: schedule.time,
                        teacher: schedule.teacher
                      );
                    },
                  ),
                );

              }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.addSchedule);
          },
          backgroundColor: AppStyles.dark,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: AppStyles.primaryLight),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
  }
