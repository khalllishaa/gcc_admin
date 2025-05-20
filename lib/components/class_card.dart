import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/OverlappingAvatar.dart';
import 'package:gcc_admin/components/StudentCard.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class KelasCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> avatarImagePaths;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final VoidCallback? onDelete;
  final bool showDeleteIcon;

  const KelasCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.avatarImagePaths = const [],
    this.backgroundColor = AppStyles.secondaryLight,
    this.textColor = AppStyles.primary,
    this.iconColor = AppStyles.primary,
    this.onDelete,
    this.showDeleteIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppStyles.classCard,
      height: AppStyles.classCard2,
      padding: EdgeInsets.all(AppStyles.paddingS),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppStyles.radiusS),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: 150,
                height: 150,
              ),
              SizedBox(width: AppStyles.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: AppStyles.spaceXXS),
                    OverlappingAvatars(
                      imagePaths: avatarImagePaths,
                      radius: 14,
                      overlap: 8,
                    ),
                  ],
                ),
              )
            ],
          ),

          if (showDeleteIcon)
            Positioned(
              top: 0,
              right: 0,
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
                    color: iconColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}