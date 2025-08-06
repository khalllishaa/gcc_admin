import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:iconly/iconly.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback? onDelete;

  const CourseCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.onDelete,
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
          // Kiri: Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.welcome2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppStyles.dark,
                ),
              ),
              SizedBox(height: AppStyles.spaceXS),
              Row(
                children: [
                  Icon(Icons.school, size: 16),
                  SizedBox(width: AppStyles.spaceXS),
                  Text(
                    subtitle,
                    style: AppStyles.welcome2.copyWith(
                      color: AppStyles.dark,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Kanan: Gambar dan Icon Delete (dipisah biar icon gak ikut geser)
          Stack(
            alignment: Alignment.topRight,
            children: [
              // Gambar digeser ke kiri pakai Transform
              Padding(
                padding: const EdgeInsets.only(right: 20), // seolah-olah geser ke kiri
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (onDelete != null)
                Positioned(
                  top: -1,
                  right: -4,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Icon(
                      IconlyBold.delete,
                      size: 20,
                      color: AppStyles.dark,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
