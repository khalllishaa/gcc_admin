import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/JournalCard.dart';
import 'package:gcc_admin/controllers/journal_controller.dart';
import 'package:gcc_admin/routes/app_route.dart';

class Journal extends StatelessWidget {
  const Journal({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final int classId = args['classId'];
    final String className = args['className'];
    JournalController journalC = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (journalC.selectedClassId.value == 0) {
        journalC.setClassId(classId);
      }
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppStyles.paddingL),
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

                // Date Picker
                Expanded(
                  child: Builder(
                    builder: (context) => Obx(() {
                      final dateText = DateFormat('dd MMMM yyyy', 'id_ID')
                          .format(journalC.selectedDate.value);
                      return InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: journalC.selectedDate.value,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            locale: const Locale('id', 'ID'),
                          );
                          if (picked != null) {
                            journalC.setDate(picked);

                            await journalC.fetchJournals();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppStyles.primaryDark,
                            borderRadius: BorderRadius.circular(AppStyles.radiusL),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: AppStyles.light, size: AppStyles.iconL),
                              SizedBox(width: AppStyles.spaceS),
                              Text(
                                dateText,
                                style: AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  onRefresh: () async {
                    await journalC.fetchJournals();
                  },
                  child: journalC.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : journalC.filteredJournals.isEmpty
                      ? ListView(
                    children: [
                      SizedBox(height: 100),
                      Center(child: Text('Belum ada jurnal untuk tanggal ini.')),
                    ],
                  )
                      : ListView.separated(
                    itemCount: journalC.filteredJournals.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppStyles.spaceS),
                    itemBuilder: (context, index) {
                      final journal = journalC.filteredJournals[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed('/view-journal', arguments: journal),
                        child: CourseCard(
                          title: journal.subject.name,
                          subtitle: journal.teacher.name,
                          imagePath: "images/student.png",
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(Routes.addJournal, arguments: {
            'classId': classId,
            'className': className,
          });

          if (result == true) {
            await journalC.fetchJournals(); // Refresh setelah submit
          }
        },
        backgroundColor: AppStyles.dark,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
      ),
    );
  }
}
