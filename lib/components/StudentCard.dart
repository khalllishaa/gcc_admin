import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final IconData icon;

  const StudentCard({
    Key? key,
    required this.name,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    this.icon = Icons.person_outline,
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
                child: Icon(icon, color: AppStyles.light),
              ),
              SizedBox(width: AppStyles.radiusM),
              Expanded(
                child: Text(
                  name,
                  style: AppStyles.welcome2.copyWith(color: AppStyles.dark),
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

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to delete this item?"),
      titleTextStyle: AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      contentTextStyle: AppStyles.welcome2,
      backgroundColor: AppStyles.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusXL),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          style: TextButton.styleFrom(
            foregroundColor: AppStyles.light,
          ),
          child: Text(
            "No",
            style: AppStyles.welcome2,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            onConfirm();
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
      ],
    );
  }
}