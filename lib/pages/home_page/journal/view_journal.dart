import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/data/models/journal_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/ViewJournalCard.dart';

class ViewJournal extends StatelessWidget {
  const ViewJournal({super.key});

  @override
  Widget build(BuildContext context) {
    final journal = Get.arguments as JournalModel;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppStyles.primaryDark,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color:AppStyles.light),
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
                    child: Text(
                      "Journal ${DateFormat('dd MMMM yyyy', 'id_ID').format(journal.createdAt)}",
                      style: AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppStyles.paddingL),
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
            // ViewJournalCard(
            //   title: "Materi",
            //   subtitle: journal.content,
            //   icon: Icons.description,
            // ),
            SizedBox(height: AppStyles.spaceL),
          ],
        ),
      ),
    );
  }
}
