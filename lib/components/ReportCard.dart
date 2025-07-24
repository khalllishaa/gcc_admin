import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class AssessmentCard extends StatelessWidget {
  final String subject;
  final String initialRating;

  const AssessmentCard({
    super.key,
    required this.subject,
    required this.initialRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppStyles.paddingM),
      padding: EdgeInsets.all(AppStyles.paddingL),
      decoration: BoxDecoration(
        color: AppStyles.secondaryLight,
        borderRadius: BorderRadius.circular(AppStyles.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject + Icon
          Row(
            children: [
              Icon(Icons.menu_book, color: AppStyles.primaryDark, size: 30),
              SizedBox(width: AppStyles.spaceS),
              Text(
                subject,
                style: AppStyles.welcome2.copyWith(
                  color: AppStyles.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          SizedBox(height: AppStyles.spaceS),

          // Description
          Text(
            'Anak memiliki tingkat pemahaman:',
            style: AppStyles.profileText1.copyWith(
              fontWeight: FontWeight.w500,
              color: AppStyles.dark,
            ),
          ),

          SizedBox(height: AppStyles.spaceS),

          // Rating badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppStyles.primaryDark,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              initialRating,
              style: TextStyle(
                color: AppStyles.light,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoteCard extends StatelessWidget {

  final String subject;
  final String initialRating;

  const NoteCard({
    super.key,
    required this.subject,
    required this.initialRating,  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppStyles.paddingM),
      padding: EdgeInsets.all(AppStyles.paddingL),
      decoration: BoxDecoration(
        color: AppStyles.secondaryLight,
        borderRadius: BorderRadius.circular(AppStyles.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_book, color: AppStyles.primaryDark, size: 30),
              SizedBox(width: AppStyles.spaceS),
              Text(
                subject,
                style: AppStyles.welcome2.copyWith(
                  color: AppStyles.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          SizedBox(height: AppStyles.spaceS),

          // Description
          Text(
            'Catatan Siswa: ' + initialRating,
            style: AppStyles.profileText1.copyWith(
              fontWeight: FontWeight.w500,
              color: AppStyles.dark,
            ),
          ),
        ],
      ),
    );
  }
}

