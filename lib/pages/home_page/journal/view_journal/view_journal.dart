import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';

import '../../../../components/ViewJournalCard.dart';

class ViewJournal extends StatelessWidget {
  const ViewJournal({super.key});

  @override
  Widget build(BuildContext context) {
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
                  icon: Icon(Icons.arrow_back, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Journal 13 Januari 2025",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
              subtitle: "Bahasa Inggris",
              icon: Icons.menu_book,
            ),
            SizedBox(height: AppStyles.spaceL),
            ViewJournalCard(
              title: "Teacher",
              subtitle: "Miss Candra",
              icon: Icons.menu_book,
            ),
            SizedBox(height: AppStyles.spaceL),
            ViewJournalCard(
              title: "Proposal",
              subtitle: "Bla Bla Bla",
              icon: Icons.menu_book,
            ),
            SizedBox(height: AppStyles.spaceL),
          ],
        ),
      ),
    );
  }
}
