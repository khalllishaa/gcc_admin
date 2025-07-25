import 'package:flutter/material.dart';
import 'package:gcc_admin/components/DatePicker.dart';
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
        print('Setting class ID to: $classId');
        journalC.setClassId(classId);
      }
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppStyles.paddingL),
        child: Column(
          children: [
            SizedBox(height: AppStyles.spaceXXL),

            // Header dengan back button dan date picker
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
                      final isToday = DateFormat('yyyy-MM-dd')
                              .format(journalC.selectedDate.value) ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now());

                      return InkWell(
                        onTap: () =>
                            CalendarPickerDialog.show(context, journalC),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppStyles.paddingL),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppStyles.primaryDark,
                            borderRadius:
                                BorderRadius.circular(AppStyles.radiusL),
                            boxShadow: [
                              BoxShadow(
                                color: AppStyles.primaryDark.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: AppStyles.light,
                                  size: AppStyles.iconL),
                              SizedBox(width: AppStyles.spaceS),
                              Expanded(
                                child: Text(
                                  isToday ? 'Hari ini, $dateText' : dateText,
                                  style: AppStyles.welcome2.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppStyles.light,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: AppStyles.light, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppStyles.spaceM),

            // Journal List
            Expanded(
              child: Obx(() {
                // Debug info (remove in production)
                if (journalC.isLoading.value) {
                  print('Loading journals...');
                } else {
                  print(
                      'Displaying ${journalC.filteredJournals.length} journals');
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    print('Refreshing journals...');
                    await journalC.refreshData();
                  },
                  color: AppStyles.primaryDark,
                  child: journalC.isLoading.value
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: AppStyles.primaryDark,
                              ),
                              SizedBox(height: AppStyles.spaceM),
                              Text(
                                'Memuat journal...',
                                style: TextStyle(
                                  color: AppStyles.dark.withOpacity(0.6),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : journalC.filteredJournals.isEmpty
                          ? ListView(
                              physics: AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(height: 100),
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.all(AppStyles.paddingXL),
                                        decoration: BoxDecoration(
                                          color:
                                              AppStyles.dark.withOpacity(0.05),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.book_outlined,
                                          size: 64,
                                          color:
                                              AppStyles.dark.withOpacity(0.3),
                                        ),
                                      ),
                                      SizedBox(height: AppStyles.spaceL),
                                      Text(
                                        'Belum ada journal',
                                        style: TextStyle(
                                          color:
                                              AppStyles.dark.withOpacity(0.8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: AppStyles.spaceS),
                                      Text(
                                        'untuk tanggal ${DateFormat('dd MMMM yyyy', 'id_ID').format(journalC.selectedDate.value)}',
                                        style: TextStyle(
                                          color:
                                              AppStyles.dark.withOpacity(0.6),
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : ListView.separated(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: journalC.filteredJournals.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: AppStyles.spaceS),
                              itemBuilder: (context, index) {
                                final journal =
                                    journalC.filteredJournals[index];
                                return GestureDetector(
                                  onTap: () => Get.toNamed('/view-journal',
                                      arguments: journal),
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
            await journalC.refreshData();
          }
        },
        backgroundColor: AppStyles.dark,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: AppStyles.primaryLight),
        tooltip: 'Tambah Journal',
      ),
    );
  }
}
