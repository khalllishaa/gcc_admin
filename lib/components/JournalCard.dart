import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const CourseCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppStyles.secondaryLight,
        borderRadius: BorderRadius.circular(AppStyles.radiusL),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold, fontSize: 18, color: AppStyles.dark),
              ),
              SizedBox(height: AppStyles.spaceXS),
              Row(
                children: [
                  Icon(Icons.school, size: 16),
                  SizedBox(width: AppStyles.spaceXS),
                  Text(
                    subtitle,
                    style: AppStyles.welcome2.copyWith(color: AppStyles.dark, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Image.asset(
            imagePath,
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
}
