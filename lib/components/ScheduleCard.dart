import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconly/iconly.dart';

import 'StudentCard.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String subject;
  final String time;
  final String teacher;
  final VoidCallback? onDelete;

  const ScheduleCard({
    super.key,
    required this.day,
    required this.subject,
    required this.time,
    required this.teacher,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 35,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
              color: AppStyles.secondaryLight,
              borderRadius: BorderRadius.circular(AppStyles.radiusL),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: -1,
                child: Text(
                  day,
                  style: AppStyles.welcome2.copyWith(
                    color: AppStyles.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppStyles.spaceS),
        Expanded(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppStyles.paddingL),
                decoration: BoxDecoration(
                  color: AppStyles.secondaryLight,
                  borderRadius: BorderRadius.circular(AppStyles.radiusM),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: AppStyles.welcome2.copyWith(
                        color: AppStyles.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: AppStyles.spaceS),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: AppStyles.primary),
                        SizedBox(width: AppStyles.spaceXS),
                        Text(
                          time,
                          style: AppStyles.welcome2.copyWith(
                            color: AppStyles.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppStyles.spaceXS),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: AppStyles.primary),
                        SizedBox(width: AppStyles.spaceXS),
                        Text(
                          teacher,
                          style: AppStyles.welcome2.copyWith(
                            color: AppStyles.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onDelete != null)
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {
                      if (onDelete != null) {
                        Get.dialog(DeleteConfirmationDialog(
                          onConfirm: onDelete!,
                        ));
                      }
                    },
                    borderRadius: BorderRadius.circular(AppStyles.radiusXL),
                    child: Padding(
                      padding: EdgeInsets.all(AppStyles.paddingS),
                      child: Icon(
                        IconlyBold.delete,
                        size: 20,
                        color: AppStyles.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
