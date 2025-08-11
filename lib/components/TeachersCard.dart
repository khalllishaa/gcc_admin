import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/StudentCard.dart';
import 'package:get/get.dart';

class Teacherscard extends StatelessWidget {
  final String name;
  final String status;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final IconData icon;

  const Teacherscard({
    Key? key,
    required this.name,
    required this.status,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    this.icon = Icons.person_outline,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppStyles.radiusL),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppStyles.primary, width: 1),
          borderRadius: BorderRadius.circular(AppStyles.radiusL),
        ),
        color: AppStyles.secondaryLight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppStyles.paddingL,
            vertical: AppStyles.paddingM,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppStyles.primary,
                child: Icon(icon, color: AppStyles.light),
              ),
              SizedBox(width: AppStyles.radiusM),
              // Expanded(
              //   child: Text(
              //     name,
              //     style: AppStyles.welcome2.copyWith(color: AppStyles.dark),
              //   ),
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyles.welcome2.copyWith(color: AppStyles.dark),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Status: $status',
                      style: AppStyles.lesson.copyWith(color: AppStyles.dark),
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(AppStyles.radiusXL),
                child: Padding(
                  padding: EdgeInsets.all(AppStyles.paddingXS),
                  child: Icon(Icons.edit_outlined, size: AppStyles.iconS),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.dialog(DeleteConfirmationDialog(
                    onConfirm: () {
                      onDelete();
                    },
                  ));
                },
                borderRadius: BorderRadius.circular(AppStyles.radiusXL),
                child: Padding(
                  padding: EdgeInsets.all(AppStyles.paddingXS),
                  child: Icon(Icons.delete_outline, size: AppStyles.iconM),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
