import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const StudentCard({
    Key? key,
    required this.name,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

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
                child: Icon(Icons.person_outline, color: AppStyles.light),
              ),
              SizedBox(width: AppStyles.radiusM),
              Expanded(
                child: Text(
                  name,
                  style: AppStyles.welcome2.copyWith(color: AppStyles.dark),
                ),
              ),
              // Edit button
              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(AppStyles.radiusXL),
                child: Padding(
                  padding: EdgeInsets.all(AppStyles.paddingXS),
                  child: Icon(Icons.edit_outlined, size: AppStyles.iconS),
                ),
              ),
              // Delete button
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: "Delete",
                    middleText: "Are you sure you want to delete this item?",
                    titleStyle: AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                    middleTextStyle: AppStyles.welcome2,
                    backgroundColor: AppStyles.primary,
                    radius: AppStyles.radiusXL,
                    barrierDismissible: false,
                    cancel: OutlinedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppStyles.light),
                      ),
                      child: Text(
                        "No",
                        style: AppStyles.welcome2,
                      ),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog first
                        onDelete(); // Then execute delete
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.primaryLight,
                        foregroundColor: AppStyles.light,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppStyles.radiusXL),
                        ),
                      ),
                      child: Text(
                        "Yes",
                        style: AppStyles.welcome2,
                      ),
                    ),
                  );
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
