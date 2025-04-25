import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class Textfield2 extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final VoidCallback onUploadPressed;

  const Textfield2({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.onUploadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppStyles.primary, width: 1.5),
        borderRadius: BorderRadius.circular(AppStyles.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppStyles.profileText2,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: AppStyles.grey1),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: AppStyles.paddingM),
            ),
          ),
          Divider(color: AppStyles.dark, thickness: 1),
          SizedBox(height: AppStyles.spaceS),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onUploadPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.radiussXL),
                ),
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL, vertical: AppStyles.paddingS),
              ),
              child: Text(
                'Upload',
                style: TextStyle(color: AppStyles.light),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
