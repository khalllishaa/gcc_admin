import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final String lessonCount;
  final String imagePath;
  final Color? backgroundColor;
  final VoidCallback? onTap; // Tambahin onTap

  const LessonCard({
    super.key,
    required this.title,
    required this.lessonCount,
    required this.imagePath,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.all(AppStyles.paddingL),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppStyles.primary,
            borderRadius: BorderRadius.circular(AppStyles.radiusM),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: AppStyles.spaceS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.heading1.copyWith(color: AppStyles.light),
                    ),
                    SizedBox(height: AppStyles.spaceM),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppStyles.paddingM,
                        vertical: AppStyles.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: AppStyles.dark.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppStyles.radiusXL),
                      ),
                      child: Text(
                        lessonCount ,
                        style: AppStyles.lesson,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Image.asset(
                imagePath,
                width: AppStyles.categoryLineHeightt,
                height: AppStyles.categoryLineHeightt,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
