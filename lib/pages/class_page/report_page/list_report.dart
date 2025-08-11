import 'package:flutter/material.dart';
import 'package:gcc_admin/pages/class_page/report_page/view_report.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/JournalCard.dart';

import '../../../controllers/reports_controller.dart';
import '../../../routes/app_route.dart';

class ListReport extends StatelessWidget {
  const ListReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());

    // Handle arguments yang bisa berupa Map atau Object
    final arguments = Get.arguments;
    final studentData =
        arguments is Map<String, dynamic> && arguments.containsKey('student')
            ? arguments['student']
            : arguments;

    // Extract data dengan safe access
    final studentId = studentData is Map<String, dynamic>
        ? studentData['id']
        : studentData?.id;
    final studentName = studentData is Map<String, dynamic>
        ? studentData['name']
        : studentData?.name;

    // Validation
    if (studentId == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: AppStyles.primaryDark),
              SizedBox(height: AppStyles.spaceM),
              Text(
                'Data student tidak valid',
                style: AppStyles.profileText2,
              ),
              SizedBox(height: AppStyles.spaceM),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }

    if (controller.allReports.isEmpty && !controller.isLoading.value) {
      Future.microtask(() => controller.fetchReports());
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
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
                    constraints: const BoxConstraints(),
                  ),
                ),
                SizedBox(width: AppStyles.spaceS),
                Expanded(
                  child: Obx(() {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppStyles.paddingS,
                          vertical: AppStyles.paddingXXS),
                      decoration: BoxDecoration(
                        color: AppStyles.secondary.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(AppStyles.radiusM),
                        border: Border.all(
                          color: AppStyles.primaryDark.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppStyles.primaryDark.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedMonth.value.isEmpty
                              ? null
                              : controller.selectedMonth.value,
                          hint: Text(
                            "Pilih Bulan",
                            style: AppStyles.welcome2.copyWith(
                              color: AppStyles.light.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          icon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: AppStyles.light),
                          isExpanded: true,
                          dropdownColor: AppStyles.secondary,
                          borderRadius: BorderRadius.circular(12),
                          items: monthNames.map((bulan) {
                            return DropdownMenuItem(
                              value: bulan,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppStyles.light.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppStyles.secondary.withOpacity(0.9),
                                ),
                                child: Text(
                                  bulan,
                                  style: AppStyles.profileText2.copyWith(
                                    color: AppStyles.light,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedMonth.value =
                                value?.isEmpty ?? true
                                    ? monthNames[DateTime.now().month - 1]
                                    : value!;
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final reportsForUser = controller.getFilteredReports(studentId);

                return RefreshIndicator(
                  onRefresh: () async {
                    controller.isLoading.value = true;
                    await controller.fetchReports();
                    controller.isLoading.value = false;
                  },
                  child: reportsForUser.isEmpty
                      ? SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: AppStyles.spaceeXL),
                                  Image.asset(
                                    'images/motorcycle.png',
                                    width: 200,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: AppStyles.spaceM),
                                  Text(
                                    'Belum ada report di bulan ini',
                                    style: AppStyles.profileText2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : ListView(
                          padding: EdgeInsets.only(top: AppStyles.paddingL),
                          children: [
                            GestureDetector(
                              onTap: () {
                                final String? note = reportsForUser.isNotEmpty
                                    ? reportsForUser.first.note
                                    : null;

                                Get.to(() => ViewReport(), arguments: {
                                  'reports': reportsForUser,
                                  'note': note,
                                });
                              },
                              child: CourseCard(
                                title: 'Report - ${studentName ?? 'Unknown'}',
                                subtitle: controller.selectedMonth.value.isEmpty
                                    ? 'Semua Bulan'
                                    : controller.selectedMonth.value,
                                imagePath: "images/student.png",
                                // onDelete: () {
                                //   final reportId = reportsForUser.first.id;
                                //   controller.deleteReport(reportId);
                                // }
                              ),
                            ),
                          ],
                        ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.toNamed('/add-report', arguments: {'userId': studentId}),
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
