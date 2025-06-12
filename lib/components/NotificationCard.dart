import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppStyles.paddingS, horizontal: AppStyles.paddingM),
      padding: EdgeInsets.all(AppStyles.paddingM),
      decoration: BoxDecoration(
        border: Border.all(color: AppStyles.primaryLight),
        borderRadius: BorderRadius.circular(AppStyles.radiusXL),
      ),
      child: Row(
        children: [
          // Icon di kiri
          Container(
            padding: EdgeInsets.all(AppStyles.paddingM),
            decoration: BoxDecoration(
              color: AppStyles.secondaryLight,
              borderRadius: BorderRadius.circular(AppStyles.radiusXL),
            ),
            child: Icon(
              icon,
              size: 25,
              color: AppStyles.primaryLight,
            ),
          ),
          SizedBox(width: AppStyles.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: AppStyles.spaceXS),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}