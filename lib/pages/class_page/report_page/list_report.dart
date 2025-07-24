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
    final student = Get.arguments; // dari StudentCard

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
        child: Column(
          children: [
            SizedBox(height: AppStyles.spaceXXL),
            Row(
              children: [
                // Back Button
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

                // Dropdown Bulan
                Expanded(
                  child: Obx(() {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingS, vertical: AppStyles.paddingXXS),
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
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppStyles.light),
                          isExpanded: true,
                          dropdownColor: AppStyles.secondary,
                          borderRadius: BorderRadius.circular(12),
                          items: monthNames.map((bulan) {
                            return DropdownMenuItem(
                              value: bulan,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppStyles.light.withOpacity(0.3)),
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
                          // onChanged: (value) {
                          //   controller.selectedMonth.value = value ?? '';
                          // },
                            onChanged: (value) {
                              controller.selectedMonth.value = value?.isEmpty ?? true
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
            // SizedBox(height: AppStyles.spaceS),
            Expanded(
              child: Obx(() {
                final reportsForUser = controller.getFilteredReports(student.id);

                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (reportsForUser.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada laporan untuk siswa ini.",
                      style: TextStyle(color: AppStyles.dark),
                    ),
                  );
                }

                return ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final String? note = reportsForUser.isNotEmpty ? reportsForUser.first.note : null;

                        Get.to(() => ViewReport(), arguments: {
                          'reports': reportsForUser,
                          'note': note,
                        });
                      },
                      child: CourseCard(
                        title: 'Report - ${student.name}',
                        subtitle: controller.selectedMonth.value.isEmpty
                            ? 'Semua Bulan'
                            : controller.selectedMonth.value,
                        imagePath: "images/student.png",
                      ),
                    ),
                  ],
                );
              }),
              // child: Obx(() {
              //   final filteredReports = controller.getFilteredReports(student.id);
              //
              //   if (controller.isLoading.value) {
              //     return Center(child: CircularProgressIndicator());
              //   }
              //
              //   if (filteredReports.isEmpty) {
              //     return Center(
              //       child: Text(
              //         "Tidak ada laporan untuk siswa ini.",
              //         style: TextStyle(color: AppStyles.dark),
              //       ),
              //     );
              //   }
              //
              //   return ListView.separated(
              //     padding:  EdgeInsets.symmetric(horizontal: AppStyles.paddingS, vertical: AppStyles.paddingS),
              //     itemCount: filteredReports.length,
              //     separatorBuilder: (context, index) => const SizedBox(height: 12),
              //     itemBuilder: (context, index) {
              //       final report = filteredReports[index];
              //       return GestureDetector(
              //         onTap: () => Get.toNamed('/view-report', arguments: report),
              //         child: CourseCard(
              //           title: 'Report ' + report.user.name,
              //           subtitle: monthNames[report.createdAt.month - 1],
              //           imagePath: "images/student.png",
              //         ),
              //       );
              //     },
              //   );
              // }),
            ),

            // Expanded(
            //   child: Obx(() {
            //     final filteredReports = controller.getFilteredReports(student.id);
            //
            //     if (controller.isLoading.value) {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //
            //     if (filteredReports.isEmpty) {
            //       return const Center(child: Text("Tidak ada laporan untuk siswa ini."));
            //     }
            //
            //     return ListView.separated(
            //       separatorBuilder: (_, __) => const SizedBox(height: 12),
            //       padding: const EdgeInsets.all(8),
            //       itemCount: filteredReports.length,
            //       itemBuilder: (context, index) {
            //         final report = filteredReports[index];
            //         return GestureDetector(
            //           onTap: () => Get.toNamed('/view-report', arguments: report),
            //           child: Container(
            //             padding: const EdgeInsets.all(16),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(12),
            //               boxShadow: const [
            //                 BoxShadow(color: Colors.black12, blurRadius: 4),
            //               ],
            //             ),
            //             child: Row(
            //               children: [
            //                 Image.asset("images/student.png", width: 40, height: 40),
            //                 const SizedBox(width: 12),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(report.subject.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            //                     Text(monthNames[report.createdAt.month - 1]),
            //                     Text("Rating: ${report.rating}"),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   }),
            // ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-report', arguments: {'userId': student.id}),
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
