import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class ViewJournalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconBackgroundColor;

  const ViewJournalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.backgroundColor = AppStyles.secondaryLight,
    this.iconBackgroundColor = AppStyles.primaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppStyles.paddingL),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppStyles.radiusL),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppStyles.paddingS),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBackgroundColor,
            ),
            child: Icon(
              icon,
              color: AppStyles.light,
            ),
          ),
          SizedBox(width: AppStyles.spaceS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.welcome2.copyWith(color: AppStyles.dark, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppStyles.spaceXS),
              Text(
                subtitle,
                style:AppStyles.welcome2.copyWith(fontSize: 14, color: AppStyles.dark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
