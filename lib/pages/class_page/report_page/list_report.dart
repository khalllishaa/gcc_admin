import 'package:flutter/material.dart';
import 'package:gcc_admin/pages/class_page/report_page/view_report.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/JournalCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../controllers/reports_controller.dart';
import '../../../routes/app_route.dart';

class ListReport extends StatefulWidget {
  const ListReport({super.key});

  @override
  State<ListReport> createState() => _ListReportState();
}

class _ListReportState extends State<ListReport> {
  dynamic student;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentFromPreferences();
  }

  // Function to load student data from SharedPreferences
  Future<void> _loadStudentFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? studentJson = prefs.getString('selected_student');

      if (studentJson != null && studentJson.isNotEmpty) {
        Map<String, dynamic> studentMap = jsonDecode(studentJson);

        // Create a student object from the JSON data
        student = _StudentFromJson(studentMap);
        print('Student loaded from SharedPreferences: $studentJson');
      } else {
        // Fallback: try to get from arguments if SharedPreferences is empty
        student = Get.arguments is Map<String, dynamic> && Get.arguments.containsKey('student')
            ? Get.arguments['student']
            : Get.arguments;
        print('Using student from arguments as fallback');
      }
    } catch (e) {
      print('Error loading student from SharedPreferences: $e');
      // Fallback to arguments
      student = Get.arguments is Map<String, dynamic> && Get.arguments.containsKey('student')
          ? Get.arguments['student']
          : Get.arguments;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Helper function to create student object from JSON
  dynamic _StudentFromJson(Map<String, dynamic> json) {
    // Create a simple object with the required properties
    return _Student(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (student == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Data siswa tidak ditemukan',
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

    final controller = Get.put(ReportController());

    if (controller.allReports.isEmpty && !controller.isLoading.value) {
      Future.microtask(() => controller.fetchReports());
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
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
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final reportsForUser = controller.getFilteredReports(student.id);

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
                              'Belum ada laporan di bulan ini',
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
                          title: 'Laporan - ${student.name}',
                          subtitle: controller.selectedMonth.value.isEmpty
                              ? 'Semua Bulan'
                              : controller.selectedMonth.value,
                          imagePath: "images/student.png",
                          // onDelete: () {
                          //   final reportId = reportsForUser.first.id; // ambil ID report yang ditampilkan
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
        onPressed: () async {
          // Navigate to add-report and wait for result
          final result = await Get.toNamed('/add-report');

          // If result indicates success, refresh the reports
          if (result != null && result is Map<String, dynamic> && result['success'] == true) {
            print('Refreshing reports after successful creation...');
            controller.isLoading.value = true;
            await controller.fetchReports();
            controller.isLoading.value = false;
          }
        },
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Simple student class for JSON mapping
class _Student {
  final int id;
  final String name;

  _Student({required this.id, required this.name});
}