import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/controllers/journal_controller.dart';
import 'package:gcc_admin/data/models/journal_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/ViewJournalCard.dart';

class ViewJournal extends StatelessWidget {
  const ViewJournal({super.key});

  @override
  Widget build(BuildContext context) {
    final journal = Get.arguments as JournalModel;

    final JournalController controller = Get.put(JournalController());
    controller.journal.value = journal;
    controller.journalId = journal.id;

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
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: AppStyles.spaceS),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppStyles.primaryDark,
                        borderRadius: BorderRadius.circular(AppStyles.radiusL),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => Text(
                          controller.getFormattedDate(),
                          style: AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppStyles.spaceM),

              Obx(() {
                // Loading state
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Error state
                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load journal',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.errorMessage.value,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // const SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: controller.retryFetch,
                        //   child: const Text('Retry'),
                        // ),
                      ],
                    ),
                  );
                }

                // No data state
                if (controller.journal.value == null) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No journal data available',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Content state
                return RefreshIndicator(
                  onRefresh: controller.refreshJournal,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(left: AppStyles.paddingS, bottom: 24),
                      child: Column(
                        children: [
                          ViewJournalCard(
                            title: "Subject",
                            subtitle: journal.subject.name,
                            icon: Icons.menu_book,
                          ),
                          SizedBox(height: AppStyles.spaceS),
                          ViewJournalCard(
                            title: "Teacher",
                            subtitle: journal.teacher.name,
                            icon: Icons.person,
                          ),
                          SizedBox(height: AppStyles.spaceS),
                          GestureDetector(
                            onTap: controller.onFileAction,
                            child: ViewJournalCard(
                              title: controller.hasFile() ? "File" : "Content",
                              subtitle: controller.getJournalContent(),
                              icon: controller.hasFile()
                                  ? Icons.attachment
                                  : Icons.description,
                            ),
                          ),
                          SizedBox(height: AppStyles.spaceL),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
