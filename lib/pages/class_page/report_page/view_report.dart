import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/ReportCard.dart';
import '../../../data/models/reports_model.dart';

class ViewReport extends StatelessWidget {
  const ViewReport({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final List<Report> reports = args['reports'];
    final String? note = args['note'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppStyles.radius),
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
                      child: CategoriesLine(
                        image: 'images/categories.png',
                        title: 'Detail Report',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),

                ...reports.map((report) => Padding(
                  padding: EdgeInsets.only(bottom: AppStyles.paddingL),
                  child: AssessmentCard(
                    subject: report.subject.name,
                    initialRating: report.rating,
                  ),
                )).toList(),

                if (note != null && note.trim().isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: NoteCard(subject: 'Catatan', initialRating: note),
                      ),
                      SizedBox(height: AppStyles.spaceL),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
